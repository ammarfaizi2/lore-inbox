Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265079AbSKESRT>; Tue, 5 Nov 2002 13:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265030AbSKESRT>; Tue, 5 Nov 2002 13:17:19 -0500
Received: from air-2.osdl.org ([65.172.181.6]:10694 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265079AbSKESRQ>;
	Tue, 5 Nov 2002 13:17:16 -0500
Date: Tue, 5 Nov 2002 10:18:56 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: David Brownell <david-b@pacbell.net>
cc: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>,
       <linux-kernel@vger.kernel.org>, <weissg@vienna.at>,
       Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Problem with USB-OHCI (2.4.20-pre10-ac2) and Sony Picturebook
 PCG-C1MHP
In-Reply-To: <3DC8068A.7020000@pacbell.net>
Message-ID: <Pine.LNX.4.33L2.0211051018060.21048-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2002, David Brownell wrote:

| Manuel Serrano wrote:
|
|  > usb-ohci.c: USB OHCI at membase 0xcf85a000, IRQ 9
|  > usb-ohci.c: usb-00:0f.0, Acer Laboratories Inc. [ALi] USB 1.1 Controller
|
| I think Pete Zaitcev had a patch for this.  Seems like recent
| incarnations of that silicon need modified init sequences.

See the archived message at
http://marc.theaimsgroup.com/?l=linux-usb-devel&m=103532223326544&w=2

This was designed for ALi in IBM i1200/i1300 notebooks.

-- 
~Randy

