Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWIUOJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWIUOJY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 10:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWIUOJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 10:09:24 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:23712 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750706AbWIUOJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 10:09:23 -0400
Date: Thu, 21 Sep 2006 08:08:26 -0600
From: Ray Lehtiniemi <rayl@shawcable.com>
Subject: Re: [ANNOUNCE] headergraphs - kernel header dependency visualizer
In-reply-to: <Pine.LNX.4.61.0609210810210.29240@yvahk01.tjqt.qr>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Message-id: <200609210808.26552.rayl@shawcable.com>
Organization: Home
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200609201217.06926.rayl@shawcable.com>
 <200609202156.10589.rayl@shawcable.com>
 <Pine.LNX.4.61.0609210810210.29240@yvahk01.tjqt.qr>
User-Agent: KMail/1.8.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 September 2006 00:11, Jan Engelhardt wrote:
> >> My gsview (on my windoze box) did not recognize media size
> >> so I had to manually adjust it afterwards.
> >
> >i have switched from postscript to png.  png files seem to render a heck
> > of a lot faster than postscript does.  hopefully there's a good windows
> > png viewer available...
>
> graphviz (/usr/bin/dot) can do SVG too.

yes, i tried viewing those with inkscape, but the strings were rendered too 
large... didn't bother to dig into whose fault it was, since png worked 
nicely when i tried it.

if this ends up being a generally useful tool, it'll be trivial to select the 
output format as a runtime option anyway.

ray
