Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287852AbSABPzm>; Wed, 2 Jan 2002 10:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287857AbSABPzd>; Wed, 2 Jan 2002 10:55:33 -0500
Received: from bs1.dnx.de ([213.252.143.130]:35560 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S287852AbSABPzW>;
	Wed, 2 Jan 2002 10:55:22 -0500
Date: Wed, 2 Jan 2002 16:54:45 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Jason Sodergren <jason@mugwump.taiga.com>,
        Anders Larsen <anders@alarsen.net>, <rkaiser@sysgo.de>
Subject: Re: [PATCH][RFC] AMD Elan patch
In-Reply-To: <Pine.LNX.4.33.0112311900380.3056-100000@callisto.local>
Message-ID: <Pine.LNX.4.33.0201021652080.3056-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Version 2.4.17.3 of the AMD Elan patch is on

  http://www.pengutronix.de/software/elan_en.html

Changelog:
----------

01/02/2002      Robert Schwebel <robert@schwebel.de>

                - Revision 2.4.17.3 released.
                - Loop inserted to check if A20 gate was
                  _really_ activated.
                  H. Peter Anvin <hpa@zytor.com>
                - We are currently unsure which would be the
                  best position for the Elan patch in the
                  kernel configuration tree. Has to be
                  discussed with maintainers.

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+

