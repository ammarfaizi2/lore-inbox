Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVCHB0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVCHB0T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 20:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVCHBVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 20:21:52 -0500
Received: from postmanpat.isu.mmu.ac.uk ([149.170.192.66]:5599 "EHLO
	postmanpat.isu.mmu.ac.uk") by vger.kernel.org with ESMTP
	id S261864AbVCHBTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 20:19:39 -0500
Subject: Re: Keyboard broken on Inspiron 5150 with 2.6.11
From: David Johnson <dj@david-web.co.uk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200503022043.35777.dtor_core@ameritech.net>
References: <200503022135.16575.dj@david-web.co.uk>
	 <d120d50005030214037e7531cb@mail.gmail.com>
	 <200503022233.12913.dj@david-web.co.uk>
	 <200503022043.35777.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 01:19:24 +0000
Message-Id: <1110244764.13765.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.6 
Content-Transfer-Encoding: 7bit
X-MMU-Signature: 823cb7940e45668b32ac5acf673ecc46
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-02 at 20:43 -0500, Dmitry Torokhov wrote:
> 
> Can you check dmesg for 2.6.11 when booted _without_ i8042.noacpi for
> messages from ACPI and i8042 please? Do you see something like following:
> 
> > ACPI: PS/2 Keyboard Controller [KBC] at I/O 0x60, 0x66, irq 1
> > ACPI: PS/2 Mouse Controller [PS2M] at irq 12
> > i8042.c: Can't read CTR while initializing i8042.
> 

Sorry for taking so long to check this out, but yes, I get exactly what
you've quoted above.

Regards,
David.

-- 
David Johnson
www.david-web.co.uk
www.penguincomputing.co.uk

