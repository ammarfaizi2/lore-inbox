Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261293AbSJLRD7>; Sat, 12 Oct 2002 13:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261294AbSJLRD7>; Sat, 12 Oct 2002 13:03:59 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:27570 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261293AbSJLRD6>; Sat, 12 Oct 2002 13:03:58 -0400
Subject: Re: lk2.2.22 and IO-apic problem (dell poweredge)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Toni Mattila <tontsa@neutech.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0210121547520.12491-100000@cyclone.neutech.fi>
References: <Pine.LNX.4.44L0.0210121547520.12491-100000@cyclone.neutech.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Oct 2002 18:21:42 +0100
Message-Id: <1034443302.15079.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-12 at 13:51, Toni Mattila wrote:
> Hi,
> 
> I have small issue with 2.2.22 kernel with Dell Poweredge 2600 server.
> 
> It finds 5 IO-apics and complains about max reached. What happens is that
> it falls back to XT-PIC and now scsi/ethernet is on same IRQ..

2.2 does not support multiprocessor pentium IV.


