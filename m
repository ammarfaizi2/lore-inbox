Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbSKXOQD>; Sun, 24 Nov 2002 09:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261318AbSKXOQC>; Sun, 24 Nov 2002 09:16:02 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:37138 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261317AbSKXOQB>; Sun, 24 Nov 2002 09:16:01 -0500
Date: Sun, 24 Nov 2002 15:23:03 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Russell King <rmk@arm.linux.org.uk>
cc: Sam Ravnborg <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>
Subject: Re: kconfig: Locate files relative to $srctree
In-Reply-To: <20021124133741.A29087@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211241449420.2109-100000@serv>
References: <20021123220747.GA10411@mars.ravnborg.org>
 <Pine.LNX.4.44.0211240250490.2113-100000@serv> <20021124133741.A29087@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> One thing that does slightly annoy me with the new config tools is the
> handling of the default configuration when you're cross-building.  In
> this circumstance, looking for the running kernel configuration seems
> wrong; it definitely isn't going to be the configuration you want to
> start from.

That didn't really came with the new tools, I took the list from the old 
Configure.
Anyway, this is another reason I'd like to make this configurable, as 
different archs might want to have different paths here.

bye, Roman

