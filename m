Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279105AbRKINiG>; Fri, 9 Nov 2001 08:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279166AbRKINhz>; Fri, 9 Nov 2001 08:37:55 -0500
Received: from bs1.dnx.de ([213.252.143.130]:5600 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S279105AbRKINho> convert rfc822-to-8bit;
	Fri, 9 Nov 2001 08:37:44 -0500
Date: Fri, 9 Nov 2001 13:27:00 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: <rkaiser@sysgo.de>
Cc: <pallaire@gameloft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel booting on serial console ... crawling
In-Reply-To: <01110910184800.01293@rob>
Message-ID: <Pine.LNX.4.33.0111091321441.12746-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, 9 Nov 2001, Robert Kaiser wrote:
> Is this an AMD Elan's built-in serial port, perchance ?

I got a patch for the Elan's serial port from Jason Sodergren some days
ago, but it's not clear to me what exactly the problem is with this port.
I'm using the serial console on a DIL/Net-PC without any problems so far.
Perhaps it might be a good idea to join forces and try to get a patch for
the Elan series into the main kernel?

However, my current affords can be found on

  http://www.schwebel.de/software/dnp/index_en.html

This currently implements a new CPU configuration parameter and a fix for
the clock on the Elan CPUs.

Robert
-- 
 +--------------------------------------------------------+
 |             Dipl.-Ing. Robert Schwebel                 |
 | Pengutronix - Linux Solutions for Science and Industry |
 |  Braunschweiger Straﬂe 79, 31134 Hildesheim, Germany   |
 |     Phone: +49-5121-28619-0  Fax: +49-5121-28619-4     |
 +--------------------------------------------------------+


