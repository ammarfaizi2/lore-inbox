Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWIUGez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWIUGez (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 02:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWIUGey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 02:34:54 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:33757 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1750707AbWIUGey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 02:34:54 -0400
Date: Thu, 21 Sep 2006 08:40:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Ray Lehtiniemi <rayl@shawcable.com>
Cc: Ray Lehtiniemi <rayl@shawcable.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] headergraphs - kernel header dependency visualizer
Message-ID: <20060921064007.GA32653@uranus.ravnborg.org>
References: <200609201217.06926.rayl@shawcable.com> <20060920220228.GA29301@uranus.ravnborg.org> <200609202156.10589.rayl@shawcable.com> <Pine.LNX.4.61.0609210810210.29240@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609210810210.29240@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 08:11:13AM +0200, Jan Engelhardt wrote:
> >
> >> My gsview (on my windoze box) did not recognize media size 
> >> so I had to manually adjust it afterwards.
> >
> >i have switched from postscript to png.  png files seem to render a heck of a 
> >lot faster than postscript does.  hopefully there's a good windows png viewer 
> >available...
> 
> graphviz (/usr/bin/dot) can do SVG too.

Reminds me...
Arnaldo (acme) made a few simple scripts that was based on dot.
They are at his home directory at kernel.org.

Care to take at look at these to see if there is something to be learned.
One good feature was that each level had a different color,
and I recall the graphs was more dense with less (confusing?) info.

	Sam
