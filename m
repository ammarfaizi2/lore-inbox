Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272172AbRIENax>; Wed, 5 Sep 2001 09:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272137AbRIENan>; Wed, 5 Sep 2001 09:30:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12805 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272172AbRIENad>; Wed, 5 Sep 2001 09:30:33 -0400
Subject: Re: hang on disk discovery
To: xavier.bestel@free.fr (Xavier Bestel)
Date: Wed, 5 Sep 2001 14:34:44 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <999696095.14164.12.camel@nomade> from "Xavier Bestel" at Sep 05, 2001 03:21:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ecpI-0005wn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have an ABit VP6 (dual PIII, VIA chipset), ACPI in kernel, I just put
> --no-mem-option in grub to see if it changes anything but no.
> The only intersting thing in dmesg seems the "unexpected IO-APIC".
> How can I help ?

Ok firstly try disabling ACPI. If that doesnt help see if booting "noapic"
helps
