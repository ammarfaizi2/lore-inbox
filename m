Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTKXOXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 09:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbTKXOXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 09:23:54 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:8339 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S263600AbTKXOXv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 09:23:51 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: linux-kernel@vger.kernel.org
Subject: Re: XawTV or bttv problem?
Date: Mon, 24 Nov 2003 09:23:50 -0500
User-Agent: KMail/1.5.1
References: <200311240907.53160.gene.heskett@verizon.net>
In-Reply-To: <200311240907.53160.gene.heskett@verizon.net>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311240923.50080.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.54.127] at Mon, 24 Nov 2003 08:23:50 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 November 2003 09:07, Gene Heskett wrote:
>Greetings;
>
>I also have a bttv (or xawtv) related problem.  At some point in the
>past I figured out howto set it for my local channel 5, ntsc via
>editing something that I don't recall the name of now.  The
> so-called channel editor button on the xawtv gui at that point did
> nothing, nada.
>
>That was a year ago.  Now I've discovered that clicking on the
> menu's channel edit button is the same as the quit 'x', with no
> messages left in the logs indicating a problem.
>
>Is this its current status, or did I manage to fubar something else?
>
>BTW, 2.6.0-test10, using the anticipatory scheduler feels good so
> far.

Since posting that, I've installed xawtv-3.88-1 with this 
configuration:

./configure  --enable-xfree-ext  --enable-xvideo  --enable-alsa \ 
--enable-mmx --enable-zvbi  --enable-xft

But it seems to have made no diff, clicking on the ADD button in the 
channel editor window is still equal to a "quit" command.  Hints 
anyone?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

