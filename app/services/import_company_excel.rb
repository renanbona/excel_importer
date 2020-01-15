class ImportCompanyExcel
  attr_accessor :path, :file, :capture_erros

  def initialize(path)
    @path = path
    @capture_erros = []
  end

  def execute
    prepare_objects
    create_records
  end

  def errors
    @capture_erros
  end

  private

  def prepare_objects
    @file = Roo::Spreadsheet.open(@path.to_s, extension: :xlsx)
    rows = @file.sheet(@file.sheets.first).to_a
    rows.shift

    @parsed_data = rows.map do |row|
      {
        name: row[0],
        code: row[1],
        token: row[2]
      }
    end
  end

  def create_records
    Company.transaction do
      begin
        Company.create!(@parsed_data)
      rescue ActiveRecord::RecordInvalid => e
        @capture_erros << e
      end
    end
  end
end
