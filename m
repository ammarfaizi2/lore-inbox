Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273423AbRINQ1k>; Fri, 14 Sep 2001 12:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273422AbRINQ1a>; Fri, 14 Sep 2001 12:27:30 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:29140 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S273427AbRINQ1T>;
	Fri, 14 Sep 2001 12:27:19 -0400
Date: Fri, 14 Sep 2001 18:26:04 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Matthias Haase <matthias_haase@bennewitz.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: repeatable SMP lockups - kernel 2.4.9
In-Reply-To: <20010914182325.225a7211.matthias_haase@bennewitz.com>
Message-ID: <Pine.LNX.4.21.0109141824580.453-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2001, Matthias Haase wrote:

> Hi, Martin,
> 
> 
> I hope, this sounds not to stupid:
> 
> As an hardware test I have run quake3d_demo with enabled DRI. 
> For this, I have compiled the 2.4.9 kernel the older DRM-code in, so I
> could use the installed Xfree86 4.03 instead the required 4.1:
>
> No error, no lockup, even though this game produced heavy load on ram and
> harddisks.
> No lockup too with the small traffic on the NIC,  for instance with the
> ADSL-connection (max. 90 kb/s) to our router.
> But, as I sayd, repeatable lockups with some higher network-traffic inside
> the LAN.

I don't think it sounds that stupid.. but if it had hung you wouldn't have
known if it was the possible interupthandeling bug or some oghet bug in
DRI/DRM :)

I'm going to start my tests here soon.

/Martin

