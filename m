Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271453AbTGQM4Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 08:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271454AbTGQM4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 08:56:15 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:43484 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S271453AbTGQM4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 08:56:14 -0400
Date: Thu, 17 Jul 2003 15:11:12 +0200
From: Ookhoi <ookhoi@humilis.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ed Sweetman <ed.sweetman@wmich.edu>, ookhoi@humilis.net,
       Takashi Iwai <tiwai@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       eugene.teo@eugeneteo.net
Subject: Re: 2.6 sound drivers?
Message-ID: <20030717131112.GA31425@favonius>
Reply-To: ookhoi@humilis.net
References: <20030716225826.GP2412@rdlg.net> <20030716231029.GG1821@matchmail.com> <20030716233045.GR2412@rdlg.net> <1058426808.1164.1518.camel@workshop.saharacpt.lan> <20030717085704.GA1381@eugeneteo.net> <s5hu19lzevt.wl@alsa2.suse.de> <20030717111958.GB30717@favonius> <3F168920.8080007@wmich.edu> <1058443806.8615.32.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058443806.8615.32.camel@dhcp22.swansea.linux.org.uk>
X-Uptime: 15:08:29 up 38 days,  2:49, 32 users,  load average: 1.00, 1.00, 1.00
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote (ao):
> On Iau, 2003-07-17 at 12:31, Ed Sweetman wrote:
> > > Wouldn't esd (the enlightment sound daemon) take care of this in
> > > userspace? I can have sound out of xmms, firebird, mpg321 and
> > > mplayer at the same time with esd.
> > 
> > Most people would rather not use esd, especially when you dont need
> > to use any userspace deamon to do the job.
> 
> There are lots of reasons for not using esd (its sucky frequency code
> for example)

I feel enlightened ;-)

> but you do need a userspace daemon because the alsa kernel side mixing
> stuff doesn't handle network connections - and nor would you want it
> to.
>
> X is a networked environment, Gnome is a networked desktop, therefore
> you need networked audio

What would be a better choice than esd?
