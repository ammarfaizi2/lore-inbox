Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286422AbSABAFm>; Tue, 1 Jan 2002 19:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286412AbSABAFc>; Tue, 1 Jan 2002 19:05:32 -0500
Received: from ns.suse.de ([213.95.15.193]:41998 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S286411AbSABAFX>;
	Tue, 1 Jan 2002 19:05:23 -0500
Date: Wed, 2 Jan 2002 01:05:21 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: <robert@schwebel.de>, Linux Kernel List <linux-kernel@vger.kernel.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Jason Sodergren <jason@mugwump.taiga.com>,
        Anders Larsen <anders@alarsen.net>, <rkaiser@sysgo.de>
Subject: Re: [PATCH][RFC] AMD Elan patch
In-Reply-To: <3C32487C.4040006@zytor.com>
Message-ID: <Pine.LNX.4.33.0201020104140.26007-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jan 2002, H. Peter Anvin wrote:

> Do you happen to know if there is an easy and safe way to detect an Elan
> at runtime? If so, it might make more sense to make this a runtime
> decision instead.

Family 4 Model 10 or so my information tells me.
Unless there are also others with the same name and different cpuid info.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

