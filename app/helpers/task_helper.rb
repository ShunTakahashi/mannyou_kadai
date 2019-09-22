module TaskHelper

  def short_time(datetime)
    datetime.strftime("%-m/%d %-H:%M")
  end

  def status_name(status)
    if status == "not_yet_arrived"
      t('views.not_yet_arrived')
    elsif status == "underway"
      t('views.underway')
    else
      t('views.complete')
    end
  end
end
