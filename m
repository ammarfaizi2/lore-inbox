Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbTCBWtO>; Sun, 2 Mar 2003 17:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbTCBWtO>; Sun, 2 Mar 2003 17:49:14 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:5380 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S261907AbTCBWtN>; Sun, 2 Mar 2003 17:49:13 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303022259.h22MxNTP000172@81-2-122-30.bradfords.org.uk>
Subject: Re: [PATCH] kernel source spellchecker
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 2 Mar 2003 22:59:22 +0000 (GMT)
Cc: elenstev@mesatop.com, dwmw2@infradead.org, dank@kegel.com, ms@citd.de,
       joe@perches.com, linux-kernel@vger.kernel.org, mike@aiinc.ca
In-Reply-To: <1046645090.3698.40.camel@irongate.swansea.linux.org.uk> from "Alan Cox" at Mar 02, 2003 10:44:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I think we also want to add:
> > > 
> > > Decompressing=Uncompressing
> 
> Both are commonly used.

To me, 'decompressed' suggests that something was definitely once
compressed, whereas 'uncompressed' suggests that it may never have been.

> People are going to far.

I totally agree.  The possibility for introducing more errors is growing.

> Fixing typos that are confusing or blatantly daft is one thing

Things like teh instead of the are easily corrected, and it's useful
for grepping through the kernel source.

> but if you want to pick over documentation line by line with a copy
> of Fowlers

What _would_ be useful, would be a script to validate all of the email
addresses in comments in the kernel source.  I found a typo in an
E-Mail address once, and I'm sure there are probably more.

John.
