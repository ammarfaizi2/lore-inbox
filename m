Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269136AbRHBUeM>; Thu, 2 Aug 2001 16:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269135AbRHBUeD>; Thu, 2 Aug 2001 16:34:03 -0400
Received: from pc1-cwbl2-0-cust80.cdf.cable.ntl.com ([62.252.63.80]:1775 "EHLO
	bagpuss.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S269130AbRHBUds>; Thu, 2 Aug 2001 16:33:48 -0400
From: Alan Cox <alan@bagpuss.swansea.linux.org.uk>
Message-Id: <200107292047.f6TKl9001473@bagpuss.swansea.linux.org.uk>
Subject: Re: Support for serial console on legacy free machines
To: khalid@fc.hp.com (Khalid Aziz)
Date: Sun, 29 Jul 2001 16:47:08 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org (Linux kernel development list),
        unlisted-recipients:;;;@fc.hp.com; (no To-header on input)
In-Reply-To: <3B66D9B9.A01685AB@fc.hp.com> from "Khalid Aziz" at Jul 31, 2001 10:15:53 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We are moving slightly off of my original question which still stands.
> For machines that do have serial ports but not at legacy addresses
> (COM1, COM2,....), is it acceptable to use the description of these
> ports as provided by SPCR and DBGP tables even though Microsoft claims
> copyright on these tables and retains the option to modify these tables
> at any time? Would it be preferable to use a table defined as part of a
> standard like ACPI 2.0 or DIG64 (such a table does not exist at this
> time but with enough votes for it, it may be added)? 

I dont think its a big issue, but if HP want to submit an alternative
open acpi owned standard to compete, well it sounds sensible

