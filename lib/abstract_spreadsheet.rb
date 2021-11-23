# frozen_string_literal: true

require 'google_drive'

class AbstractSpreadsheet
  def data
    @data ||= rows_without_headers.map do |row|
      data = {}

      headers.to_a.each_with_index do |header, i|
        data[header] = row[i]
      end

      data
    end
  end

  protected

  def tab_name
    fail NotImplementedError
  end

  private

  def headers
    @headers ||= content_tab.rows[0]
  end

  def rows_without_headers
    @rows_without_headers ||= content_tab.rows[1..-1]
  end

  def content_tab
    @content_tab ||= content_spreadsheet.worksheets.find do |worksheet|
      worksheet.title == tab_name
    end
  end

  def content_spreadsheet
    @content_spreadsheet ||= session.spreadsheet_by_key(content_spreadsheet_id)
  end

  def content_spreadsheet_id
    '126oFuO-SeKhE-Glb1_-8kprCxfXnYGJl-TpCxXI-c9I'
  end

  def session
    @session ||= GoogleDrive::Session.from_service_account_key(absolute_file_path('../secrets/google-credentials.json'))
  end

  def absolute_file_path(path)
    File.expand_path(
      File.join(
        File.dirname(__FILE__),
        path
      )
    )
  end
end
