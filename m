Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRD2RGL>; Sun, 29 Apr 2001 13:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135840AbRD2RGC>; Sun, 29 Apr 2001 13:06:02 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:25535 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129084AbRD2RFl>; Sun, 29 Apr 2001 13:05:41 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200104291705.SAA27622@mauve.demon.co.uk>
Subject: Re: Lid support.
To: linux-kernel@vger.kernel.org
Date: Sun, 29 Apr 2001 18:05:15 +0100 (BST)
In-Reply-To: <20010427104411.A37@(none)> from "Pavel Machek" at Apr 27, 2001 10:44:11 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hi!
> 
> > I assume there is no generic APM support for lid-close?
> > My BIOS (P100 DEC CTS5100 Hinote VP) has no way to do anything other
> > than beep, when the lid is closed, so I'm using a hack that polls the
> > ct65548 video chips registers to find when the BIOS turns the LCD off,
> > so I can do whatever.
> > 
> > Or is there a better wya?
> 
> Yes, going ACPI. But you'll need current acpi, not the one in 2.4.3

Is ACPI really likely to be in a Sep 95 laptop?

Isn't it usually mentioned in the BIOS?
