Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267172AbSKSXtn>; Tue, 19 Nov 2002 18:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267582AbSKSXtn>; Tue, 19 Nov 2002 18:49:43 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:9344 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267172AbSKSXtm>; Tue, 19 Nov 2002 18:49:42 -0500
Subject: Re: AMD 760MPX dma_intr: error=0x40 { UncorrectableError }
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steven Timm <timm@fnal.gov>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.31.0211191529360.12125-100000@boxer.fnal.gov>
References: <Pine.LNX.4.31.0211191529360.12125-100000@boxer.fnal.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 00:24:59 +0000
Message-Id: <1037751899.1401.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-19 at 21:36, Steven Timm wrote:
> There are many entries in this mailing list saying that
> the above error is a sign of a bad disk.  Seagate diagnostics
> say so too.. It is just hard to believe that 30 hard drives could
> go bad in less than a month.

Really ? - if they came from the same batch, with the same fault or
dropped off the back of the same truck. One of the problems with raid
setups is exactly this.

This error has nothing to do with the chipset, the drive itself provided
that assessment of its state and Seagates own diagnostics are querying
the drive data.

