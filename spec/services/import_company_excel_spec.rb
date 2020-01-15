require 'rails_helper'

RSpec.describe ImportCompanyExcel do
  describe '#execute' do
    context 'with a valid excel' do
      it 'should import new companies' do
        path = Rails.root.join('spec', 'fixtures', 'company_sucess.xlsx')
        import_excel = ImportCompanyExcel.new(path)

        import_excel.execute

        expect(import_excel.errors.count).to eq(0)
      end
    end

    context 'with an invalid excel' do
      it 'should not import new companies' do
        path = Rails.root.join('spec', 'fixtures', 'company_fail.xlsx')
        import_excel = ImportCompanyExcel.new(path)

        import_excel.execute

        expect(import_excel.errors.count).not_to eq(0)
      end
    end
  end
end
