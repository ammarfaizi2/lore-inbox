Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261394AbSJCPO2>; Thu, 3 Oct 2002 11:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbSJCPNB>; Thu, 3 Oct 2002 11:13:01 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:3569 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261539AbSJCPMz>; Thu, 3 Oct 2002 11:12:55 -0400
Subject: Re: Linux 2.5.40-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Alan Cox <alan@redhat.com>, Greg Ungerer <gerg@snapgear.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021003155122.A20437@infradead.org>
References: <20021003151707.A17513@infradead.org>
	<200210031420.g93EK3L07983@devserv.devel.redhat.com> 
	<20021003155122.A20437@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 16:25:38 +0100
Message-Id: <1033658738.28814.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 15:51, Christoph Hellwig wrote:
> Did you actually take a look?  Many files are basically the same and other
> are just totally stubbed out in nommu.

Basically but never entirely - if you can see a way to clean that up
nicely that Linus would accept other than mmnommu then thats even
better. I couldnt see a way of getting enough ifdefs out of the tree

