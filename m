Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbTA1OE5>; Tue, 28 Jan 2003 09:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbTA1OE5>; Tue, 28 Jan 2003 09:04:57 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:47376 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265532AbTA1OE4>; Tue, 28 Jan 2003 09:04:56 -0500
Subject: Re: Bootscreen
From: "Richard B. Tilley " "(Brad)" <rtilley@vt.edu>
To: John Bradford <john@grabjohn.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, wichert@wiggy.net,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200301281406.h0SE6U1t000751@darkstar.example.net>
References: <200301281406.h0SE6U1t000751@darkstar.example.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 Jan 2003 09:14:15 -0500
Message-Id: <1043763256.6794.1.camel@oubop4.bursar.vt.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-28 at 09:06, John Bradford wrote:
> > > It takes a while before the kernel starts init though, especially if you
> > > have things like SCSI controllers to initialise. If you do not use fb
> > > you can have your bootloader setup a pretty bootscreen, but if you need
> > > fb I don't see how you can prevent the textscreen with kernel messages.
> > 
> > I'd not really pondered people who compile many drivers into their kernel
> > instead of into the initrd. I guess a few people still do that.
> 
> I don't usually compile support for modules in at all.

Me neither. Guess we're a part of the "few"


