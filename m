Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbUDNBwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 21:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263613AbUDNBwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 21:52:06 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:43452 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263191AbUDNBwD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 21:52:03 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Cef (LKML)" <cef-lkml@optusnet.com.au>
Subject: Re: [PATCH] QD65xx I/O ports
Date: Wed, 14 Apr 2004 03:52:10 +0200
User-Agent: KMail/1.5.3
References: <Pine.GSO.4.58.0404061330470.4158@waterleaf.sonytel.be> <20040413134708.GB13298@harddisk-recovery.com> <200404141140.04101.cef-lkml@optusnet.com.au>
In-Reply-To: <200404141140.04101.cef-lkml@optusnet.com.au>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404140352.10523.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 of April 2004 03:40, Cef (LKML) wrote:
> On Tue, 13 Apr 2004 11:47 pm, Erik Mouw wrote:
> > On Fri, Apr 09, 2004 at 12:50:24AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > On Tuesday 06 of April 2004 13:31, Geert Uytterhoeven wrote:
> > > > I/O port numbers can be larger than 8-bit on many platforms (this
> > > > caused a warning when {out,in}b() cast reg to a pointer on platforms
> > > > with memory mapped I/O)
> > >
> > > Was VESA Local Bus ever used on something else than 486?
> >
> > IIRC there were early Pentium boards with VESA Local Bus (VLB), but my
> > memory is vague about that.
>
> I can confirm that. I used to own one of those beasts. PCI, VLB & ISA all
> on the one board. First generation Pentium's (+5v core) only as far as I
> remember.

Yes, you are right.  I also remember them. :-)

