Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281128AbRK0PzJ>; Tue, 27 Nov 2001 10:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281321AbRK0Py7>; Tue, 27 Nov 2001 10:54:59 -0500
Received: from pcow025o.blueyonder.co.uk ([195.188.53.125]:48644 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S281319AbRK0Pyu>;
	Tue, 27 Nov 2001 10:54:50 -0500
Date: Tue, 27 Nov 2001 15:04:49 +0000
From: Ian Molton <imolton@clara.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 'spurious 8259A interrupt: IRQ7'
Message-Id: <20011127150449.2b60eef8.imolton@clara.net>
In-Reply-To: <2116.10.119.8.1.1006873174.squirrel@extranet.jtrix.com>
In-Reply-To: <E168jk1-0001J7-00@the-village.bc.nu>
	<2116.10.119.8.1.1006873174.squirrel@extranet.jtrix.com>
Reply-To: spyro@armlinux.org
Organization: The dragon roost
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a sunny Tue, 27 Nov 2001 14:59:34 -0000 (GMT) Martin A. Brooks gathered
a sheaf of electrons and etched in their motions the following immortal
words:

> 
> > With IO Apic support included ? If you are using an AMD/VIA combo
> > chipset board that would explain it
> 
> Yup
> 
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y

Same here.

what /is/ IOAPIC? I always turned it on, but never bothered to check up on
what it is (its safe to just have it, right?)
