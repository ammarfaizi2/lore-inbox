Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbTA1Odb>; Tue, 28 Jan 2003 09:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265650AbTA1Odb>; Tue, 28 Jan 2003 09:33:31 -0500
Received: from [81.2.122.30] ([81.2.122.30]:16389 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265543AbTA1Oda>;
	Tue, 28 Jan 2003 09:33:30 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301281443.h0SEhSGk001163@darkstar.example.net>
Subject: Re: Bootscreen
To: wichert@wiggy.net (Wichert Akkerman)
Date: Tue, 28 Jan 2003 14:43:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030128142837.GX4868@wiggy.net> from "Wichert Akkerman" at Jan 28, 2003 03:28:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Surely the most sensible lines to think along are:
> > 
> > * Make boot times as short as possible
> 
> So with a short boot time instead of seeing text messages for a while
> you'll get some flickering on the screen - I don't call that an
> improvement.

Well, if the machine boots up OK, you can always review the messages
with dmesg.  If it doesn't, the messages are there to review.

> > * Support, and encourage the use of more efficient CPU designs, so
> >   that it becomes sensible to leave machines on all the time.
> 
> Unfortunately in the real world we are dealing with existing cheap
> hardware.

Well, my current IA-32 box is hopefully going to be my last :-).

John.
