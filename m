Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbSKRQNE>; Mon, 18 Nov 2002 11:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSKRQNE>; Mon, 18 Nov 2002 11:13:04 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:14602 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S262887AbSKRQNC> convert rfc822-to-8bit;
	Mon, 18 Nov 2002 11:13:02 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.48] Config.help misleading
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Mon, 18 Nov 2002 17:06:54 +0100
Message-ID: <871y5iuajl.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Help says to say "Y" if unsure, but that isn't allowed:
,----
|   UHCI HCD (most Intel and VIA) support (USB_UHCI_HCD) [N/m/?] (NEW) ?
| 
| The Universal Host Controller Interface is a standard by Intel for
| accessing the USB hardware in the PC (which is also called the USB
| host controller). If your USB host controller conforms to this
| standard, you may want to say Y, but see below. All recent boards
| with Intel PCI chipsets (like intel 430TX, 440FX, 440LX, 440BX,
| i810, i820) conform to this standard. Also all VIA PCI chipsets
| (like VIA VP2, VP3, MVP3, Apollo Pro, Apollo Pro II or Apollo Pro
| 133). If unsure, say Y.
| 
| This code is also available as a module ( = code which can be
| inserted in and removed from the running kernel whenever you want).
| The module will be called uhci-hcd.o. If you want to compile it as a
| module, say M here and read <file:Documentation/modules.txt>.
| 
|   UHCI HCD (most Intel and VIA) support (USB_UHCI_HCD) [N/m/?] (NEW) y
`----

Jochen

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.
