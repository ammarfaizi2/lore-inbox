Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270272AbTHLN0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 09:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270325AbTHLN0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 09:26:04 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:31872 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S270272AbTHLN0B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 09:26:01 -0400
Date: Tue, 12 Aug 2003 16:22:45 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Lars Duesing <ld@stud.fh-muenchen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test3mm1 + gcc 3.2.3 | gcc3.3 compile error (Input/output
 error)
In-Reply-To: <1060694115.22608.3.camel@ws1.intern.stud.fh-muenchen.de>
Message-ID: <Pine.LNX.4.56.0308121621280.8716@hosting.rdsbv.ro>
References: <Pine.LNX.4.56.0308121603010.8716@hosting.rdsbv.ro>
 <1060694115.22608.3.camel@ws1.intern.stud.fh-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Catalin,
> > arch/i386/kernel/built-in.o: could not read symbols: Input/output error
> > make: *** [.tmp_vmlinux1] Error 1
> There it says :)
> ld could not read data from harddisk - either it is full, or corrupted.
I have space on disk.
cat "arch/i386/kernel/built-in.o > /dev/null" works ok, without errors
(dmesg).

Other ideas?

>
> greetings,
>
>  Lars
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro
