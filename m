Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbTAaVD7>; Fri, 31 Jan 2003 16:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbTAaVD7>; Fri, 31 Jan 2003 16:03:59 -0500
Received: from [81.2.122.30] ([81.2.122.30]:19460 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S262418AbTAaVD7>;
	Fri, 31 Jan 2003 16:03:59 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301312114.h0VLEB68000351@darkstar.example.net>
Subject: Re: [PATCH] 2.5.59 morse code panics
To: ehw@lanl.gov (Eric Weigle)
Date: Fri, 31 Jan 2003 21:14:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030131210802.GL3250@lanl.gov> from "Eric Weigle" at Jan 31, 2003 02:08:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > you're just angry that I've left out your original
> > > > > plain_blinking code.
> > > > 
> > > > Well, there are typically *three* keyboard LEDs...  Why not use one
> > > > the middle one for morse, and outside two for plain blinking?
> > > 
> > > Then put out the stuff in octal...
> > Or maybe even have a nice scrolling binary display...
> Or even better, time it so that when you twirl the keyboard around
> by its cord in a dark room, the LEDs print the message into the air
> a-la the skyliner

> (http://www.theskyliner.com/)

Might be a problem for cordless keyboards, though - not sure how we'd
support those.

John.
