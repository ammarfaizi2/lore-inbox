Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130093AbQLHO2B>; Fri, 8 Dec 2000 09:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130465AbQLHO1m>; Fri, 8 Dec 2000 09:27:42 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21520 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130093AbQLHO1k>; Fri, 8 Dec 2000 09:27:40 -0500
Subject: Re: Kernel Development Documentation?
To: caperry@edolnx.net
Date: Fri, 8 Dec 2000 13:59:14 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A3066A5.7E173772@edolnx.net> from "Carl Perry" at Dec 07, 2000 10:41:51 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144O3Q-0003vP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a project underway that documents how things like the VM, the Memory
> Manger, what a a specific driver needs to do, what it needs to return, how it is
> called, what do all those files in arch/whatever do?  Are there bits and pieces

For the kernel stuff there is a project to put documentation about functions
and what they do inline into the kernel. Its slow progress. Trying to do 
anything formal and structured isnt going to be productive until the 
documentation is much much more complete

For syscalls Andries Brouwer maintains a man page collection (and writes many
of them). He takes submissions.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
