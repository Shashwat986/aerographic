start = <<ENDL
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>{{title}} - Aerographic Papers Private Limited, Nagpur</title>

    <meta name="twitter:card" content="summary" />

    <meta name="description" content="Aerographic Papers Private Limited - Manufacturer of VCI Packaging, VCI Paper & VCI Films from Nagpur, Maharashtra, India" />
    <meta property="og:description" content="Aerographic Papers Private Limited - Manufacturer of VCI Packaging, VCI Paper & VCI Films from Nagpur, Maharashtra, India" />
    <meta name="keywords" content="VCI Packaging, VCI Paper, VCI Films, Non VCI Industrial Packaging Products, VCI Bag, Wax Paper, VCI Products, Aerographic Papers Private Limited, Nagpur" />
    <meta name="twitter:description" content="Aerographic Papers Private Limited - Manufacturer of VCI Packaging, VCI Paper & VCI Films from Nagpur, Maharashtra, India" />

    <meta name="twitter:title" content="Aerographic Papers Private Limited, Nagpur - Manufacturer of VCI Paper" />
    <meta property="og:title" content="Aerographic Papers Private Limited, Nagpur - Manufacturer of VCI Paper" />
    <meta property="og:url" content="http://aerographicpapers.com/{{title_slug}}.html" />
    <link rel="canonical" href="http://aerographicpapers.com/{{title_slug}}.html">

    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" />
    <link href="style.css" rel="stylesheet" />

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>
    <div class="container title">
      <div class="row">
        <div class="col-xs-12">
          <a href="/">
          <img src="images/aerographic-papers-private-limited-logo-120x120.png" class="pull-left margin-right-10">
          <h1>Aerographic Papers Private Limited</h1>
          <h4>MIDC, Nagpur, Maharashtra</h4>
          </a>
        </div>
      </div>
    </div>
    <header id="header"></header>
    <div class="container-fluid">
      <div class="container">
        <div class="row">
          <center class="col-xs-12">
            <h2>{{title}}</h2>
          </center>
        </div>
        <div class="row">
          <div class="col-xs-12">
            {{description}}
            <hr>
          </div>
        </div>
ENDL

mid = <<ENDL
        <div class="row indiv-item" id="{{slug}}">
          <div class="col-xs-12 media">
            <div class="media-left media-middle">
              <a href="#">
                <img src="images/{{image_filename}}">
              </a>
            </div>
            <div class="media-body">
              <h3>
                {{title}}
                <small>
                  <br/>
                  Approximate Price: {{price}}
                </small>
              </h3>
              <p>
                {{description}}
              </p>
              {% if advantages %}
                <h5>Advantages</h5>
                <ul>
                  {% for adv in advantages %}
                    <li>{{adv}}</li>
                  {% endfor %}
                </ul>
              {% endif %}
            </div>
          </div>
        </div>
ENDL

foot = <<ENDL

        <hr>
      </div>
    </div> <!-- /container -->

    <footer id="footer"></footer>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript">
      $(document).ready(function () {
        $("#header").load("header.html");
        $("#footer").load("footer.html");
      });
    </script>
  </body>
</html>
ENDL

require 'json'
require 'liquid'

def stringify_keys hash
  hash.map do |k, v|
    [k.to_s, v]
  end.to_h
end

data = JSON.parse(File.read('data.json'))

data.each do |key, file_data|
  options = stringify_keys(
    title_slug: key,
    title: file_data['title'],
    description: file_data['description']
  )
  output = Liquid::Template.parse(start).render(options)
  file_data['items'].each do |item|
    output += Liquid::Template.parse(mid).render(item)
  end

  output += Liquid::Template.parse(foot).render()

  File.open(key + ".html", "w") do |f|
    f.write(output)
  end
end
