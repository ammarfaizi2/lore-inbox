Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286508AbSABBKu>; Tue, 1 Jan 2002 20:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286468AbSABBKk>; Tue, 1 Jan 2002 20:10:40 -0500
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:11020 "HELO
	hog.ctrl-c.liu.se") by vger.kernel.org with SMTP id <S286491AbSABBK0>;
	Tue, 1 Jan 2002 20:10:26 -0500
From: Christer Weinigel <wingel@hog.ctrl-c.liu.se>
To: hpa@zytor.com
Cc: robert@schwebel.de, linux-kernel@vger.kernel.org, jason@mugwump.taiga.com,
        anders@alarsen.net, rkaiser@sysgo.de, tytso@mit.edu
In-Reply-To: <3C3258DF.5000908@zytor.com> (hpa@zytor.com)
Subject: Re: [PATCH][RFC] AMD Elan patch
Reply-To: wingel@t1.ctrl-c.liu.se
In-Reply-To: <Pine.LNX.4.33.0112311900380.3056-100000@callisto.local> <3C322EEE.5040402@zytor.com> <20020102000609.6B6C136F9F@hog.ctrl-c.liu.se> <3C3258DF.5000908@zytor.com>
Message-Id: <20020102011024.AFDCE36F9F@hog.ctrl-c.liu.se>
Date: Wed,  2 Jan 2002 02:10:24 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> The reason to use the BIOS first is to give the platform vendor a
> hook to deal with platform-specific issues, and God knows there are
> plenty of those when it comes to A20. 

Well, the Elan SC4x0 doesn't have a lot of issues, everything having
to do with A20 is on the chip itself, so it would take a really brain
damaged design to mess this up. :-)

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"
