Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbUDNBkO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 21:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263613AbUDNBkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 21:40:14 -0400
Received: from mail018.syd.optusnet.com.au ([211.29.132.72]:10202 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263605AbUDNBkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 21:40:09 -0400
From: "Cef (LKML)" <cef-lkml@optusnet.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] QD65xx I/O ports
Date: Wed, 14 Apr 2004 11:40:02 +1000
User-Agent: KMail/1.6.1
References: <Pine.GSO.4.58.0404061330470.4158@waterleaf.sonytel.be> <200404090050.24841.bzolnier@elka.pw.edu.pl> <20040413134708.GB13298@harddisk-recovery.com>
In-Reply-To: <20040413134708.GB13298@harddisk-recovery.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404141140.04101.cef-lkml@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2004 11:47 pm, Erik Mouw wrote:
> On Fri, Apr 09, 2004 at 12:50:24AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday 06 of April 2004 13:31, Geert Uytterhoeven wrote:
> > > I/O port numbers can be larger than 8-bit on many platforms (this
> > > caused a warning when {out,in}b() cast reg to a pointer on platforms
> > > with memory mapped I/O)
> >
> > Was VESA Local Bus ever used on something else than 486?
>
> IIRC there were early Pentium boards with VESA Local Bus (VLB), but my
> memory is vague about that.

I can confirm that. I used to own one of those beasts. PCI, VLB & ISA all on 
the one board. First generation Pentium's (+5v core) only as far as I 
remember.

