Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129059AbRBSXfZ>; Mon, 19 Feb 2001 18:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbRBSXfQ>; Mon, 19 Feb 2001 18:35:16 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:5391
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129059AbRBSXfF>; Mon, 19 Feb 2001 18:35:05 -0500
Date: Mon, 19 Feb 2001 15:34:41 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>
cc: Pozsar Balazs <pozsy@sch.bme.hu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] meaningless #ifndef?
In-Reply-To: <20010219173153.B12609@ganymede.isdn.uiuc.edu>
Message-ID: <Pine.LNX.4.10.10102191533270.4861-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Bill Wendling wrote:

> The use of the ternary operator is superfluous, though...and makes the
> code look ugly IMNSHO :).

What is ugly is that the commitee can not decide if there is going to be
host-side only, device-side only or both-side.

Cheers,

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

