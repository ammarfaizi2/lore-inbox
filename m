Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317580AbSHNMQh>; Wed, 14 Aug 2002 08:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317592AbSHNMQg>; Wed, 14 Aug 2002 08:16:36 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:5871 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317580AbSHNMQf>; Wed, 14 Aug 2002 08:16:35 -0400
Subject: Re: [2.4.20-pre2] CPiA kernel panic
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Plantagenet <plantagenet@music.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208140409.g7E499320183@mail20.bigmailbox.com>
References: <200208140409.g7E499320183@mail20.bigmailbox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 Aug 2002 13:18:14 +0100
Message-Id: <1029327494.26226.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-14 at 05:09, Peter Plantagenet wrote:
> V4L-Driver for Vision CPiA based cameras v0.7.4
> usb.c: registered new driver cpia
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000 printing eip:
> c0119e3c
> * pde=00000000
> Oops: 0002
> EIP: 0010: [<c0119e3c>] Not tainted
> EFLAGS 00010002

As it happens I just sent Marcelo a set of USB camera driver updates
hopefully in time for pre3

