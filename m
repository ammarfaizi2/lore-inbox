Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTLDQAo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 11:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbTLDQAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 11:00:44 -0500
Received: from ihemail2.lucent.com ([192.11.222.163]:14827 "EHLO
	ihemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S262566AbTLDQAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 11:00:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16335.23048.950612.696818@gargle.gargle.HOWL>
Date: Thu, 4 Dec 2003 11:00:08 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Mathieu Chouquet-Stringer <mathieu@newview.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP Kernel 2.6.0-test11 doesn't boot on a Dell 410
In-Reply-To: <20031204135415.GA9913@shookay.newview.com>
References: <20031204135415.GA9913@shookay.newview.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mathieu> I just tried the latest 2.6.0 (test11) on a Dell 410 (a
Mathieu> bi-PIII) and the SMP flavor of this kernel doesn't work at
Mathieu> all. The non-smp one works well (so I know it's not a case of
Mathieu> VT/VGA console missing).

It's also been hanging on my Dell Precision 610 MT box, dual 550Mhz
Xeon CPUs.  

Mathieu> It dies (without any error message) after this:
Mathieu> Uncompressing Linux... Ok, booting the kernel

Same here.  

Mathieu> I tried disabling APIC in the BIOS but it doesn't make any
Mathieu> difference...

I tried booting with noapic, but it didn't make any difference here.
I'm trying to boot using a bzImage kernel, if that makes any
difference.

John


