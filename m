Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264966AbSJVUSN>; Tue, 22 Oct 2002 16:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264957AbSJVURO>; Tue, 22 Oct 2002 16:17:14 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:5307 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264938AbSJVUPz>; Tue, 22 Oct 2002 16:15:55 -0400
Subject: Re: [patch] generic nonlinear mappings, 2.5.44-mm2-D0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.44.0210222220480.22282-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0210222220480.22282-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 21:38:08 +0100
Message-Id: <1035319088.31873.149.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 21:27, Ingo Molnar wrote:
> limit. I do not realistically believe that any 32-bit x86 box that is
> connected to a larger than 2 TB disk array cannot possibly run a PAE
> kernel. Just like you need PAE for more than 4 GB physical RAM. I find it
> a bit worrisome that 32-bit x86 ptes can only support up to 4 GB of
> physical RAM, but such is life :-)

Actually I know a few. 2Tb is cheap - its one pci controller and eight
ide disks.

