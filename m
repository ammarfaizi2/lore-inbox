Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268157AbUI2C0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268157AbUI2C0n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 22:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268159AbUI2C0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 22:26:42 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:39561 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268157AbUI2C0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 22:26:07 -0400
Subject: Re: mlock(1)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jonathan@jonmasters.org
Cc: Robert White <rwhite@casabyte.com>, Andrea Arcangeli <andrea@novell.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Chris Wright <chrisw@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <35fb2e59040928181676b15c1b@mail.gmail.com>
References: <20040928221520.GF4084@dualathlon.random>
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAA1iD23Ya0SUu9c8LflyEkKQEAAAAA@casabyte.com>
	 <35fb2e59040928181676b15c1b@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096421006.14637.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Sep 2004 02:23:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-29 at 02:16, Jon Masters wrote:
> I don't see in your argument how this is meant to be cryptographically
> secure. Nor do I see from any of the original mail an idea which does
> anything more than offer a fake promise of security to those who are
> willing to assume only dumb criminals steal their laptop. This is
> worse than no security at all and renders the idea of encrypting swap
> completely useless.

Most criminals are dumb. That means a boot screen that says 
"Property of Dave Miller, if found please leave anywhere in Tahoe"
"Password:"

and a boot/bios password will defeat them and may get the laptop dumped
back where it can be recovered.

Thus don't rule out the value of the deterrent It isnt appropriate if
you leave national secrets on the train like all our finest government
employees keep doing obviously.

> 1). I open the laptop up (I'm allowed to do that if I've already nicked it :P).
> 2). I take a copy of the BIOS.
> 3). I replace the BIOS with a hardware configuration (however done -
> perhaps hot swapping chips, perhaps some simple logic device helps me)
> in which the original BIOS is available once booting begins.
> 4). That part of the security model was just destroyed.

This threat level is why secure systems people use smartcards for the
encryption keys and related processing. Just don't leave the smartcard
on the train!

