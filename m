Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319264AbSIEW4D>; Thu, 5 Sep 2002 18:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319269AbSIEW4C>; Thu, 5 Sep 2002 18:56:02 -0400
Received: from postal2.lbl.gov ([131.243.248.26]:5568 "EHLO postal2.lbl.gov")
	by vger.kernel.org with ESMTP id <S319264AbSIEWyj>;
	Thu, 5 Sep 2002 18:54:39 -0400
Message-ID: <3D77E1C2.560B6646@lbl.gov>
Date: Thu, 05 Sep 2002 15:59:14 -0700
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-10smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre5-ac3
References: <200209052258.g85Mw8322267@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Sep  5 12:11:21 localhost kernel: hde: TOSHIBA CD-ROM XM-7002Bc, ATAPI
> > CD/DVD-ROM drive
> > Sep  5 12:11:21 localhost kernel: ide2 at 0x180-0x187,0x386 on irq 3
> > Sep  5 12:11:21 localhost kernel: ide_cs: hde: Vcc = 5.0, Vpp = 0.0
> > Sep  5 12:11:21 localhost cardmgr[854]: executing: './ide start hde'
> > Sep  5 12:11:21 localhost kernel: hde: bad special flag: 0x03
> >
> > [locked tight]
> 
> On the end of the insert or on the removal ?

just after the insert.
