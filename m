Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287882AbSABRbJ>; Wed, 2 Jan 2002 12:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287879AbSABRa7>; Wed, 2 Jan 2002 12:30:59 -0500
Received: from bs1.dnx.de ([213.252.143.130]:59368 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S287882AbSABRau>;
	Wed, 2 Jan 2002 12:30:50 -0500
Date: Wed, 2 Jan 2002 18:26:23 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Jason Sodergren <jason@mugwump.taiga.com>,
        Anders Larsen <anders@alarsen.net>, <rkaiser@sysgo.de>
Subject: Re: [PATCH][RFC] AMD Elan patch
In-Reply-To: <Pine.LNX.4.33.0201021749070.3056-100000@callisto.local>
Message-ID: <Pine.LNX.4.33.0201021823210.3056-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Robert Schwebel wrote:
> I've already searched through all manuals I could find on the AMD site
> (http://www.amd.com/epd/processors/4.32bitcont/13.lan4xxfam/23.lansc410/index.html)
> but couldn't find anything related to the CPUID command...

Aaargh, does anyone have a brown paper bag for me? The infomration is in
the User Manual.

Model  0ah means "enhanced Am486 SX1 write back mode"
Family 04h means "Am486 CPU"

Which IMHO doesn't say that this combination means _exactly_ the SC410.

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+

