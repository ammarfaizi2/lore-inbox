Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbSLJJL0>; Tue, 10 Dec 2002 04:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSLJJL0>; Tue, 10 Dec 2002 04:11:26 -0500
Received: from p0010.as-l043.contactel.cz ([194.108.242.10]:30450 "EHLO
	SnowWhite.janik.cz") by vger.kernel.org with ESMTP
	id <S262789AbSLJJLZ> convert rfc822-to-8bit; Tue, 10 Dec 2002 04:11:25 -0500
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>
Subject: Re: PCI serial card with PCI 9052?
References: <m3smxx1aaf.fsf@Janik.cz> <20021120095618.GB319@pazke.ipt>
	<m3fztrcinh.fsf@Janik.cz>
	<20021124114307.A25408@flint.arm.linux.org.uk>
	<m3vg2naupr.fsf@Janik.cz> <20021125094828.GA6016@pazke.ipt>
	<m3hee55qc6.fsf@Janik.cz>
	<20021201110202.E24114@flint.arm.linux.org.uk>
	<m3vg22pd19.fsf@Janik.cz> <20021210073021.GA3051@pazke.ipt>
From: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
X-Face: $"d&^B_IKlTHX!y2d,3;grhwjOBqOli]LV`6d]58%5'x/kBd7.MO&n3bJ@Zkf&RfBu|^qL+
 ?/Re{MpTqanXS2'~Qp'J2p^M7uM:zp[1Xq#{|C!*'&NvCC[9!|=>#qHqIhroq_S"MH8nSH+d^9*BF:
 iHiAs(t(~b#1.{w.d[=Z
Date: Tue, 10 Dec 2002 09:10:08 +0100
In-Reply-To: <20021210073021.GA3051@pazke.ipt> (Andrey Panin's message of
 "Tue, 10 Dec 2002 10:30:21 +0300")
Message-ID: <m3ptsanvkv.fsf@Janik.cz>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i386-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrey Panin <pazke@orbita1.ru>
   Date: Tue, 10 Dec 2002 10:30:21 +0300

Hi,

   > Looks like this card needs special PLX related magic to work with interrupts.
   > Can you try to set pci_plx9050_fn() as init function for this card ?

of course - immediately after setserial autoconfig the system goes to
Hollywood :-( I did not got the chance to debug it further, unfortunately.
-- 
Pavel Janík

Q: Why are we hiding from the police daddy?
A: Because we use vi son, they use emacs.
                  -- Thinkgeek.com T-Shirt 
