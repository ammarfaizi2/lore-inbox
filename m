Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318915AbSHEXBG>; Mon, 5 Aug 2002 19:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318927AbSHEXBF>; Mon, 5 Aug 2002 19:01:05 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:57333 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318915AbSHEXBF>; Mon, 5 Aug 2002 19:01:05 -0400
Subject: Re: Oopses
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gregory Stark <gsstark@mit.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87sn1sgbcp.fsf@stark.dyndns.tv>
References: <87sn1sgbcp.fsf@stark.dyndns.tv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Aug 2002 01:23:31 +0100
Message-Id: <1028593411.18130.131.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-06 at 00:00, Gregory Stark wrote:
> 
> I received these two oopses recently running 2.4.17. Is this a known bug? 
> Is it fixed in 2.4.18?
> 
> Aug  5 17:43:07 stark kernel: Unable to handle kernel paging request at virtual address e0f390e8
> Aug  5 17:43:07 stark kernel:  printing eip:
> Aug  5 17:43:07 stark kernel: c0140cfc
> Aug  5 17:43:07 stark kernel: *pde = 00000000
> Aug  5 17:43:07 stark kernel: Oops: 0002
> Aug  5 17:43:07 stark kernel: CPU:    0
> Aug  5 17:43:08 stark kernel: EIP:    0010:[get_empty_inode+44/160]    Tainted: PF

What binary modules are you running, and what did you use insmod -f on ?

