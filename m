Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262345AbTCIBvf>; Sat, 8 Mar 2003 20:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262346AbTCIBvf>; Sat, 8 Mar 2003 20:51:35 -0500
Received: from tapu.f00f.org ([202.49.232.129]:53170 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S262345AbTCIBvf>;
	Sat, 8 Mar 2003 20:51:35 -0500
Date: Sat, 8 Mar 2003 18:02:12 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Greg KH <greg@kroah.com>, hch@infradead.org, Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030309020212.GA17975@f00f.org>
References: <Pine.LNX.4.44.0303071708260.1796-100000@home.transmeta.com> <1047136177.25932.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047136177.25932.25.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 03:09:37PM +0000, Alan Cox wrote:

> Is there any reason for not using CIDR like schemes as Al Viro
> proposed a long time back (I think it was Al anyway). That also
> sorts out the auditing problem

Some of of CIDR approach seems extremely elegant and reasonable
scalable to me...  look how far the (relatively) poorly managed
Internet-address space has gotten with similar ideas...


  --cw
