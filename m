Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSGPJjm>; Tue, 16 Jul 2002 05:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSGPJjl>; Tue, 16 Jul 2002 05:39:41 -0400
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:7070 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S311749AbSGPJjk>; Tue, 16 Jul 2002 05:39:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bernd Schubert <bernd-schubert@web.de>
To: es034@freenet.carleton.ca, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x kernels cause random launch of xscreensaver?
Date: Tue, 16 Jul 2002 11:42:32 +0200
User-Agent: KMail/1.4.2
References: <02071517260100.00186@cooper>
In-Reply-To: <02071517260100.00186@cooper>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207161142.32479.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Eric posted a workaround for this problem to this list.

http://www.reric.net/linux/viatimer/

Regards, Bernd

On Tuesday 16 July 2002 00:26, Richard Sembera wrote:
> Hi all,
>
> I asked around in the Slackware NG about this problem last week and got
> redirected here. I hope someone can help. I'm not subscribed to the mailing
> list so please cc me copies of your replies.
>
> On Slackware 8.0, when I try to install the 2.4.5 kernel, I get a problem
> with X, namely, xscreensaver starts up at random intervals. Sometimes the
> problem shows up immedately, sometimes it takes longer (the longest period
> so far has been 2 days). While I'm working, xscreensaver will suddenly go
> off, complain about not being able to grab the mose pointer, and launch a
> random screen saver. After typing in my password to unlock the screen,
> xscreensaver launches again after an interval of about 2-10 seconds.
>
> If I disable xscreensaver in my .xinitrc file (or try fvwm2 instead of my
> standard xfce), then instead of xscreensaver I just get a blank screen, as
> if there were no video signal. Moving the mouse gets me a normal display,
> but at 2-5 second intervals the screen will simply black out as described.
>
> I've tried installing the 2.4.18 kernel but got the same problem. The
> 2.2.19 kernel works just fine, however. I've also experienced the same
> problem with SuSE 7.1 and a 2.4.0 kernel.
>
> It was suggested in the Slackware NG that it might be a clock problem. I do
> have the "clock timer configuration lost--probably a VIA686" message coming
> up intermittently at boot time and during shutdown, although I don't have a
> VIA chipset (in fact, this is why I switched to Slack, which by default
> doesn't log or display kernel messages).
>
> I hope someone can offer suggestions or advice. I'm including as much
> trechnical information as seems relevant, though I'm just a hobbyist, so
> please ask if something's not quite clear.
>
> Thanks in advance,
>
> Richard Sembera.
