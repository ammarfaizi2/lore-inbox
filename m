Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293230AbSCOTuJ>; Fri, 15 Mar 2002 14:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293236AbSCOTt7>; Fri, 15 Mar 2002 14:49:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42511 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293230AbSCOTtz>; Fri, 15 Mar 2002 14:49:55 -0500
Subject: Re: bug (trouble?) report on high mem support
To: john.helms@photomask.com (John Helms)
Date: Fri, 15 Mar 2002 20:05:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, Jim.Trice@photomask.com (Trice Jim)
In-Reply-To: <20020315.19251700@linux.local> from "John Helms" at Mar 15, 2002 07:25:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lxxL-0004WN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> running under the 2.4.7-10 enterprise 
> kernel.  This same program runs fine
> under the 2.4.7-10 smp kernel.  The main

Firstly queue standard comment about 2.4.9 errata kernels and upgrading

> difference is that in a top output, most
> of the cpu time is in system mode and very
> little user mode under the enterprise kernel,
> and just the opposite under the smp kernel.

When you are using large amounts of RAM things in the PC world get a bit
messy. Is this a box with a lot of memory ?
