Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284956AbSACJNX>; Thu, 3 Jan 2002 04:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284823AbSACJNN>; Thu, 3 Jan 2002 04:13:13 -0500
Received: from bs1.dnx.de ([213.252.143.130]:25835 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S284944AbSACJNB>;
	Thu, 3 Jan 2002 04:13:01 -0500
Date: Thu, 3 Jan 2002 09:52:33 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Jason Sodergren <jason@mugwump.taiga.com>,
        Anders Larsen <anders@alarsen.net>, <rkaiser@sysgo.de>
Subject: Re: [PATCH][RFC] AMD Elan patch
In-Reply-To: <3C338C57.2080902@zytor.com>
Message-ID: <Pine.LNX.4.33.0201030951560.3056-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, H. Peter Anvin wrote:
> That's not the problem, really... the problems is that CPUID identifies
> the CPU core, and embedded CPU cores tend to be used and reused many
> times -- in fact, AMD are quite good at that.

Sounds reasonably. I think we should stay with the configuration option at
the moment.

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+

