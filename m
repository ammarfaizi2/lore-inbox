Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316678AbSGHA2C>; Sun, 7 Jul 2002 20:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316681AbSGHA2B>; Sun, 7 Jul 2002 20:28:01 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:24970 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S316678AbSGHA2A>;
	Sun, 7 Jul 2002 20:28:00 -0400
Subject: Re: NAPI patch against 2.4.18
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Jason Lunz <lunz@gtf.org>
Cc: Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020707191517.GA14331@orr.falooley.org>
References: <3D287DA4.5090904@candelatech.com> 
	<20020707191517.GA14331@orr.falooley.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 08 Jul 2002 02:30:34 +0200
Message-Id: <1026088234.1283.246.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-07 at 21:15, Jason Lunz wrote:
> 
> greearb@candelatech.com said:
> > Does anyone have a working NAPI kernel and tulip driver patch against
> > 2.4.18 or so?  I will be happy to test this if so.
> 
> Yes, I backported the core last week to 2.4.19-rc1 from 2.5.24, but the
> patch ought to apply to 2.4.18 with only offset mismatches. I kept a lot
> of style cleanups in the patch, but they should be easy to remove if
> they cause problems. I'll be backporting the various napified drivers to
> 2.4 this week.
> 
> http://orr.falooley.org/pub/linux/net/

Why not use the original patch?

ftp://robur.slu.se/pub/Linux/net-development/NAPI/

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat
you with experience.
