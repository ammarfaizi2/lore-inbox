Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265799AbUHCLwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbUHCLwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 07:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbUHCLwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 07:52:38 -0400
Received: from the-village.bc.nu ([81.2.110.252]:28346 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265799AbUHCLwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 07:52:37 -0400
Subject: Re: PATCH: Add support for IT8212 IDE controllers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Elmar Hinz <elmar.hinz@vcd-berlin.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <410F7407.8070903@vcd-berlin.de>
References: <2obsK-5Ni-13@gated-at.bofh.it> <410F7407.8070903@vcd-berlin.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091530208.3573.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 03 Aug 2004 11:50:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-03 at 12:16, Elmar Hinz wrote:
> Alan Cox wrote:
> > There is a messy scsi faking vendor driver for this card but this instead
> > is a standard Linux IDE layer driver.
> > 
> 
> I try to answer to this post. As I newly subscribed to this list, I 
> probably won't catch the original thread.

Not your fault - I missed out an include file update when I posted it -
PCI_DEVICE_ID_ITE_8212 is 0x8212..

