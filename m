Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262047AbTCHPnR>; Sat, 8 Mar 2003 10:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262048AbTCHPnQ>; Sat, 8 Mar 2003 10:43:16 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:18443 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262047AbTCHPnQ>; Sat, 8 Mar 2003 10:43:16 -0500
Date: Sat, 8 Mar 2003 15:53:46 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Greg KH <greg@kroah.com>, hch@infradead.org, Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308155346.A28797@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andrew Morton <akpm@digeo.com>, Greg KH <greg@kroah.com>,
	Andries.Brouwer@cwi.nl,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303071708260.1796-100000@home.transmeta.com> <1047136177.25932.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1047136177.25932.25.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sat, Mar 08, 2003 at 03:09:37PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 03:09:37PM +0000, Alan Cox wrote:
> Is there any reason for not using CIDR like schemes as Al Viro proposed a long
> time back (I think it was Al anyway). That also sorts out the auditing problem

Al did implement it for block devices, it's already in 2.5.

