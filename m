Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265002AbSKRX6M>; Mon, 18 Nov 2002 18:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbSKRX6L>; Mon, 18 Nov 2002 18:58:11 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:7606 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264950AbSKRX6K>; Mon, 18 Nov 2002 18:58:10 -0500
Subject: Re: Why /dev/sdc1 doesn't show up...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Alexander Viro <viro@math.psu.edu>, Doug Ledford <dledford@redhat.com>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20021118235221.637162C456@lists.samba.org>
References: <20021118235221.637162C456@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Nov 2002 00:32:39 +0000
Message-Id: <1037665959.9625.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-18 at 23:49, Rusty Russell wrote:
> In message <Pine.GSO.4.21.0211180403440.23400-100000@steklov.math.psu.edu> you 
> write:
> > Not really.  For case in question (block devices) there is only one path
> > and I'd rather keep it that way, thank you very much.
> 
> See other posting.  This is a fundamental design decision, and it's
> not changing.  Sorry.

So is the block layer one, and it was fundamentally designed first 8)

