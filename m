Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264294AbTEGUOw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 16:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbTEGUNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 16:13:13 -0400
Received: from smtp-out.comcast.net ([24.153.64.113]:6738 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264294AbTEGUMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 16:12:48 -0400
Date: Wed, 07 May 2003 16:20:36 -0400
From: Chris <kingsqueak@kingsqueak.org>
Subject: Re: Tyan Tiger MP + 2.4.20
In-reply-to: <Pine.LNX.4.55.0305071201130.709@death>
To: Ken Witherow <ken@krwtech.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <20030507202036.GA14197@mrhat.kingsqueak.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <S263086AbTEGLmI/20030507114208Z+5636@vger.kernel.org>
 <Pine.LNX.4.55.0305071201130.709@death>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I disabled APM and ACPI long ago with my Tiger MPX with dual MP
1600's.  Ever since I've had no issues at all with the box.  I had
random issues at boot mostly with ACPI enabled,  since I had no need
for either APM or ACPI I canned them both and things are just peachy
now.

On Wed, May 07, 2003 at 12:07:02PM -0400, Ken Witherow wrote:
> On Wed, 7 May 2003, Steve Spencer wrote:
> 
> > Hey folks,
> >
> > Has anyone else experienced stability issues with 2.4.20 and Tyan Tiger
> > MP mobo/Athlon MP processors?
> > I think it may be a power management issue since reboot doesn't work
> > properly; the machine screens go into power save mode but the box doesnt
> > come back up ...
> >
> > Any thoughts?
> 
> I have a 2460 wtih dual 1800 MPs. When I first got it, I had all kinds of
> weird stability issues (random hangs, spontaneous reboots, etc) which
> turned out to be a power supply that just wasn't beefy enough. Each of
> the processors can eat up to 66 watts, so by the time you throw in drives,
> AGP cards, etc, you're drawing a lot of power. I upgraded to a top quality
> 550 watt power supply and the stability issues cleared up.
> 
> As for hanging after rebooting, it appears to be related to ACPI in 2.4
> not being complete, as 2.5 works as expected.
> 
> -- 
>        Ken Witherow <phantoml AT rochester.rr.com>
>            ICQ: 21840670  AIM: phantomlordken
>                http://www.krwtech.com/ken
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
   __ ___                                  __  
  / //_(_)__  _http://www.kingsqueak.org _/ /__
 / ,< / / _ \/ _ `(_-</ _ `/ // / -_) _ `/  '_/
/_/|_/_/_//_/\_, /___/\_, /\_,_/\__/\_,_/_/\_\ 
            /___/      /_/GPG KEY finger 
	    	         @kingsqueak.org		
