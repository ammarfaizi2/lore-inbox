Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280104AbRK0O7P>; Tue, 27 Nov 2001 09:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280101AbRK0O7F>; Tue, 27 Nov 2001 09:59:05 -0500
Received: from gateway-2.hyperlink.com ([213.52.152.2]:18440 "EHLO
	core-gateway-1.hyperlink.com") by vger.kernel.org with ESMTP
	id <S280002AbRK0O65>; Tue, 27 Nov 2001 09:58:57 -0500
Message-ID: <2116.10.119.8.1.1006873174.squirrel@extranet.jtrix.com>
Date: Tue, 27 Nov 2001 14:59:34 -0000 (GMT)
Subject: Re: 'spurious 8259A interrupt: IRQ7'
From: "Martin A. Brooks" <martin@jtrix.com>
To: <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E168jk1-0001J7-00@the-village.bc.nu>
In-Reply-To: <E168jk1-0001J7-00@the-village.bc.nu>
Cc: <lkml@patrickburleson.com>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.0 [rc2])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> With IO Apic support included ? If you are using an AMD/VIA combo
> chipset board that would explain it

Yup

CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

Martin A. Brooks.


