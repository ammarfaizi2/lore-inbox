Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269073AbRHBTh1>; Thu, 2 Aug 2001 15:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269076AbRHBThR>; Thu, 2 Aug 2001 15:37:17 -0400
Received: from pc1-cwbl2-0-cust80.cdf.cable.ntl.com ([62.252.63.80]:253 "EHLO
	bagpuss.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S269073AbRHBTg7>; Thu, 2 Aug 2001 15:36:59 -0400
From: Alan Cox <alan@bagpuss.swansea.linux.org.uk>
Message-Id: <200107292135.f6TLZWK01608@bagpuss.swansea.linux.org.uk>
Subject: Re: GPL issuefor run time kernel function overwrite
To: kumarm4@hotmail.com (kumar M)
Date: Sun, 29 Jul 2001 17:35:31 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, kumarm4@hotmail.com
In-Reply-To: <F56FOSPUPeKljq65Rn800008a48@hotmail.com> from "kumar M" at Jul 30, 2001 02:14:03 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * We implement a driver which will overwrite any existing
> (global kernel data strcuture) function pointer in linux
> kernel space run-time.
> * No kernel source code is modified in the process.

You modify a GPL program and link with it. I'd say its quite clear
you are linking 
