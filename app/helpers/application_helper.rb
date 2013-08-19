module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Asia Fan"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def new_micropost
  	@micropost = current_user.microposts.build(params[:micropost])
  end

  def recent_activity
    @activities = PublicActivity::Activity.limit(12).order("created_at DESC")
  end

  def randomized_background_image
    images = ["/images/2ne1acoustic.jpg", "/images/cl2ne1.jpg", "/images/bom_iloveu.jpg", "/images/tokyocitynight.jpg", "/images/japangundam.jpg", "/images/bigbangbluemv.jpg", "/images/carnightdrift.jpg", "/images/phodacbiet.jpg", "/images/tokyonight.jpg", "/images/initial2.png", "/images/ggeneration.jpg", "/images/skyline.jpg", "/images/moodgirl.jpg", "/images/silvias13.jpg", "/images/tmntnes.jpg", "/images/dragongirlanime.jpg", "/images/animegirlmood.jpg", "/images/animehug.jpg", "/images/animegirlawesome.jpg", "/images/evo.jpg", "/images/chineselantern.jpg", "/images/bruceleedrawing.jpg"]
    images[rand(images.size)]
  end

  def youtube_embed(youtube_url)
    if youtube_url[/youtu\.be\/([^\?]*)/]
      youtube_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end
    %Q{<iframe title="YouTube video player" width="560" height="315" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
  end

end