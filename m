Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319260AbSIEWx5>; Thu, 5 Sep 2002 18:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319261AbSIEWx4>; Thu, 5 Sep 2002 18:53:56 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:45324 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S319260AbSIEWxk>; Thu, 5 Sep 2002 18:53:40 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200209052258.g85Mw8322267@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.20-pre5-ac3
To: tadavis@lbl.gov (Thomas Davis)
Date: Thu, 5 Sep 2002 18:58:08 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3D77D311.BC1D94EC@lbl.gov> from "Thomas Davis" at Sep 05, 2002 02:56:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sep  5 12:11:21 localhost kernel: hde: TOSHIBA CD-ROM XM-7002Bc, ATAPI
> CD/DVD-ROM drive
> Sep  5 12:11:21 localhost kernel: ide2 at 0x180-0x187,0x386 on irq 3
> Sep  5 12:11:21 localhost kernel: ide_cs: hde: Vcc = 5.0, Vpp = 0.0
> Sep  5 12:11:21 localhost cardmgr[854]: executing: './ide start hde'
> Sep  5 12:11:21 localhost kernel: hde: bad special flag: 0x03
> 
> [locked tight]

On the end of the insert or on the removal ?
