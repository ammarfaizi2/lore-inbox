Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312547AbSCUWmo>; Thu, 21 Mar 2002 17:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312548AbSCUWm0>; Thu, 21 Mar 2002 17:42:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61968 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312547AbSCUWmK>; Thu, 21 Mar 2002 17:42:10 -0500
Subject: Re: module (kernel) debugging
To: HGadi@ecutel.com (Hari Gadi)
Date: Thu, 21 Mar 2002 22:58:26 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <AF2378CBE7016247BC0FD5261F1EEB210B6A93@EXCHANGE01.domain.ecutel.com> from "Hari Gadi" at Mar 21, 2002 05:15:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16oBVq-0006Z6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am new to kernel level development. What are the best ways to debug runtime
> kernel (module).

Your brain 8)

> Are there any third party tools for debugging the kernel.

Several

	kgdb	-	debug the kernel with gdb from another PC
	kdb	-	patch for in kernel debugger
	UML	-	user mode linux (good for fs not so good for driver
			work)
