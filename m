Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbSJLTO0>; Sat, 12 Oct 2002 15:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261325AbSJLTOZ>; Sat, 12 Oct 2002 15:14:25 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:38066 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261322AbSJLTOZ>; Sat, 12 Oct 2002 15:14:25 -0400
Subject: Re: lk2.2.22 and IO-apic problem (dell poweredge)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Toni Mattila <tontsa@neutech.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0210122054280.12491-100000@cyclone.neutech.fi>
References: <Pine.LNX.4.44L0.0210122054280.12491-100000@cyclone.neutech.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Oct 2002 20:32:13 +0100
Message-Id: <1034451133.15067.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-12 at 18:57, Toni Mattila wrote:
> Does lk2.2 lack something substansial on P-IV SMP arena, or is it just 
> matter of back porting some small bits from 2.4?

IRQ balancing, C0 errata support, hyperthreading, tlb fixes to avoid odd
random segfaults...


