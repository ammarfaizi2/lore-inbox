Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285306AbRLFXZU>; Thu, 6 Dec 2001 18:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285305AbRLFXZO>; Thu, 6 Dec 2001 18:25:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20484 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285304AbRLFXZD>; Thu, 6 Dec 2001 18:25:03 -0500
Subject: Re: [PATCH] eepro100 - need testers
To: thockin@sun.com (Tim Hockin)
Date: Thu, 6 Dec 2001 23:34:06 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        arjanv@redhat.com, saw@sw-soft.com, sparker@sparker.net
In-Reply-To: <3C0D54DF.4E897B70@sun.com> from "Tim Hockin" at Dec 04, 2001 02:57:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16C81m-0003Zm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch was developed here to resolve a number of eepro100 issues we
> were seeing. I'd like to get people to try this on their eepro100 chips and
> beat on it for a while.

Works for me. Its the first eepro100 driver that wont choke eventually on
my i810 board and its also the only one that will recover the board after
a soft boot when it had previously started spewing errors

Alan
