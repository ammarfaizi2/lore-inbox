Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312358AbSDEHwK>; Fri, 5 Apr 2002 02:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312361AbSDEHwA>; Fri, 5 Apr 2002 02:52:00 -0500
Received: from bs1.dnx.de ([213.252.143.130]:14044 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S312358AbSDEHvr>;
	Fri, 5 Apr 2002 02:51:47 -0500
Date: Fri, 5 Apr 2002 09:26:39 +0200 (CEST)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: moving some boot code out of arch directories
In-Reply-To: <m1u1qrqxfm.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0204050920180.16178-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Apr 2002, Eric W. Biederman wrote:
> A have some thoughts but nothing to concrete right now.  On every
> architecture booting seems to be a completely roll your own solution.
> Which I find very annoying.  This one of the reasons I am also working
> on general linux booting linux support.  If we could get as far as a
> bootloader that works on multiple architectures perhaps we could start
> to unify some of these things.

You might want to have a look at PPCboot / ARMboot (the latter one is a
recent port to ARM) which seems to be very interesting! Only a port to x86
is missing (or, better, a unified project...)

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+

