Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271822AbRIEOGH>; Wed, 5 Sep 2001 10:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272079AbRIEOF7>; Wed, 5 Sep 2001 10:05:59 -0400
Received: from AMontpellier-201-1-1-55.abo.wanadoo.fr ([193.252.31.55]:26125
	"EHLO awak") by vger.kernel.org with ESMTP id <S271822AbRIEOFq>;
	Wed, 5 Sep 2001 10:05:46 -0400
Subject: Re: hang on disk discovery
From: Xavier Bestel <xavier.bestel@free.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E15ecpI-0005wn-00@the-village.bc.nu>
In-Reply-To: <E15ecpI-0005wn-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.08.30.16.57 (Preview Release)
Date: 05 Sep 2001 16:01:30 +0200
Message-Id: <999698491.14164.17.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On mer, 2001-09-05 at 15:34, Alan Cox wrote:
> > I have an ABit VP6 (dual PIII, VIA chipset), ACPI in kernel, I just put
> > --no-mem-option in grub to see if it changes anything but no.
> > The only intersting thing in dmesg seems the "unexpected IO-APIC".
> > How can I help ?
> 
> Ok firstly try disabling ACPI. If that doesnt help see if booting "noapic"
> helps

OK, it works well after disabling ACPI, thanks.
Anything quick I can do to help debug this ?



