Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbSKERtF>; Tue, 5 Nov 2002 12:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbSKERtF>; Tue, 5 Nov 2002 12:49:05 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:48337 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S265095AbSKERtA>; Tue, 5 Nov 2002 12:49:00 -0500
Date: Tue, 05 Nov 2002 09:57:30 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: Problem with USB-OHCI (2.4.20-pre10-ac2) and Sony Picturebook
 PCG-C1MHP
To: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
Cc: linux-kernel@vger.kernel.org, weissg@vienna.at,
       Pete Zaitcev <zaitcev@redhat.com>
Message-id: <3DC8068A.7020000@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20021105103602.7c1282fa.Manuel.Serrano@sophia.inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manuel Serrano wrote:

 > usb-ohci.c: USB OHCI at membase 0xcf85a000, IRQ 9
 > usb-ohci.c: usb-00:0f.0, Acer Laboratories Inc. [ALi] USB 1.1 Controller

I think Pete Zaitcev had a patch for this.  Seems like recent
incarnations of that silicon need modified init sequences.

- Dave






