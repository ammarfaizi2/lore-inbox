Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312605AbSCVB1X>; Thu, 21 Mar 2002 20:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312607AbSCVB1N>; Thu, 21 Mar 2002 20:27:13 -0500
Received: from ns.suse.de ([213.95.15.193]:46861 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312605AbSCVB1D>;
	Thu, 21 Mar 2002 20:27:03 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, HGadi@ecutel.com
Subject: Re: module (kernel) debugging
In-Reply-To: <AF2378CBE7016247BC0FD5261F1EEB210B6A93@EXCHANGE01.domain.ecutel.com.suse.lists.linux.kernel> <E16oBVq-0006Z6-00@the-village.bc.nu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 22 Mar 2002 02:26:56 +0100
Message-ID: <p73zo111jfj.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> 
> 	kgdb	-	debug the kernel with gdb from another PC
> 	kdb	-	patch for in kernel debugger
> 	UML	-	user mode linux (good for fs not so good for driver
> 			work)
        pice    -       Private Ice. Source level debugger for modules, 
                        doesn't need a kernel patch and works with a single
                        machine. 2.2/UP only at the 
                        moment, but can be ported to 2.4. Loosely similar to 
                        Softice on Windows.

-Andi
