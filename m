Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280981AbRKOSeH>; Thu, 15 Nov 2001 13:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280982AbRKOSdr>; Thu, 15 Nov 2001 13:33:47 -0500
Received: from mustard.heime.net ([194.234.65.222]:55962 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S280981AbRKOSdp>; Thu, 15 Nov 2001 13:33:45 -0500
Date: Thu, 15 Nov 2001 19:33:34 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux i/o tweaking
In-Reply-To: <Pine.LNX.4.33.0111151009380.28958-100000@twin.uoregon.edu>
Message-ID: <Pine.LNX.4.30.0111151930360.14530-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I guess the question I'd ask would be what kinda number do you expect from
> the raid 5 stripe. 107MB/s sounds like a reasonable number from a two
> channel u160 controller...

I really don't know. My 'logical' mind told me I could get close-to
speed-per-disk * number-of-disks, but it might be wrong.

> my previous best is around 89MB/s with 4 cheetah 15K 18gb drives raid/0

I had 5 drives per SCSI bus and the controller was sitting alone on a
66MHz/64bit PCI hose.  I really can't see where the bottleneck is!

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

