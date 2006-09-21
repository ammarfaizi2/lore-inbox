Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWIUD5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWIUD5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 23:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWIUD5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 23:57:45 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:41864 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751189AbWIUD5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 23:57:45 -0400
Date: Wed, 20 Sep 2006 21:56:09 -0600
From: Ray Lehtiniemi <rayl@shawcable.com>
Subject: Re: [ANNOUNCE] headergraphs - kernel header dependency visualizer
In-reply-to: <20060920220228.GA29301@uranus.ravnborg.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <200609202156.10589.rayl@shawcable.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200609201217.06926.rayl@shawcable.com>
 <20060920220228.GA29301@uranus.ravnborg.org>
User-Agent: KMail/1.8.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 September 2006 16:02, Sam Ravnborg wrote:
> On Wed, Sep 20, 2006 at 12:17:06PM -0600, Ray Lehtiniemi wrote:
> > Greetings,
> >
> > I got interested in tracing kernel header file dependencies and wrote yet
> > another Perl script to generate PostScript using graphviz.  Folks
> > interested in that sort of thing are invited to check out:
> >
> >    http://www.kernel.org/pub/linux/kernel/people/rayl/headergraphs/
>
> Hi Ray.
>
> Look nice.

thanks :-)


> My gsview (on my windoze box) did not recognize media size 
> so I had to manually adjust it afterwards.

i have switched from postscript to png.  png files seem to render a heck of a 
lot faster than postscript does.  hopefully there's a good windows png viewer 
available...



> Is it possible to make the images smaller so we could fit more
> information in less space?

i've made a few changes to increase the graph density, but it's still a little 
on the sparse side.  please check the url above for updated readme and sample 
images.


ray
