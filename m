Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267026AbSKLXiZ>; Tue, 12 Nov 2002 18:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267031AbSKLXiY>; Tue, 12 Nov 2002 18:38:24 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:30120 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267026AbSKLXiW>; Tue, 12 Nov 2002 18:38:22 -0500
Subject: Re: FW: i386 Linux kernel DoS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Leif Sawyer <lsawyer@gci.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021112233150.A30484@infradead.org>
References: <BF9651D8732ED311A61D00105A9CA3150B45FB3C@berkeley.gci.com> 
	<20021112233150.A30484@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 00:10:19 +0000
Message-Id: <1037146219.10083.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-12 at 23:31, Christoph Hellwig wrote:
> On Tue, Nov 12, 2002 at 02:28:55PM -0900, Leif Sawyer wrote:
> > This was posted on bugtraq today...
> 
> A real segfaulting program?  wow :)

Looks like the TF handling bug which was fixed a while ago

