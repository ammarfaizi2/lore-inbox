Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129468AbRCBUTP>; Fri, 2 Mar 2001 15:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129470AbRCBUTF>; Fri, 2 Mar 2001 15:19:05 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:62983
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129468AbRCBUSx>; Fri, 2 Mar 2001 15:18:53 -0500
Date: Fri, 2 Mar 2001 12:18:44 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Thomas Dodd <ted@cypress.com>
cc: linux-kernel@vger.kernel.org,
        Hylke van der Schaaf <hylke@lx.student.wau.nl>
Subject: Re: DMA on a AMD7409 controller with kernel 2.4.2
In-Reply-To: <3A9FBCB4.3F3931F8@cypress.com>
Message-ID: <Pine.LNX.4.10.10103021217120.3868-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001, Thomas Dodd wrote:

> > >  using_dma    =  0 (off)

DMA is off and I bet you did not enable the new AUTODMA config setting.


Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

