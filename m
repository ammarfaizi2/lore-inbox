Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131163AbRCMXqv>; Tue, 13 Mar 2001 18:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131238AbRCMXqm>; Tue, 13 Mar 2001 18:46:42 -0500
Received: from saarinen.org ([203.79.82.14]:9123 "EHLO vimfuego.saarinen.org")
	by vger.kernel.org with ESMTP id <S131478AbRCMXqd>;
	Tue, 13 Mar 2001 18:46:33 -0500
From: "Juha Saarinen" <juha@saarinen.org>
To: "Pete Toscano" <pete@toscano.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: APIC  usb MPS 1.4 and the 2.4.2 kernel
Date: Wed, 14 Mar 2001 12:48:36 +1300
Message-ID: <LNBBIBDBFFCDPLBLLLHFGEFGJGAA.juha@saarinen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010313183105.H5626@bubba.toscano.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:: AFAIK, the option to compile w/o APIC is only for UP systems.  If you
:: want to use both of your processors, you have to compile in APIC
:: support, but just disable it when loading the kernel (ie. for lilo,
:: 'append="noapic"')

I haven't seen the beginning of the APIC/VIA/Tyan thread, but isn't there a
way to check if the APIC's OK, instead of resorting to workarounds like the
above?

:: That would explain why it works for me.  Now, if only I didn't have
:: devices that need to have their BIOSes upgraded via a Windows .exe...

;-).

That's a good point, actually. I can't recall a single BIOS or device BIOS
flasher that works under anything but DOS (or in some cases, Windows). Is
there any work being done on this for Linux?

-- Juha

