Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264112AbTLEN2o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 08:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264118AbTLEN2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 08:28:44 -0500
Received: from 5.86.35.65.cfl.rr.com ([65.35.86.5]:25984 "EHLO
	drunkencodepoets.com") by vger.kernel.org with ESMTP
	id S264112AbTLEN2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 08:28:43 -0500
Date: Fri, 5 Dec 2003 08:28:55 -0500
From: Pat Erley <paterley@mail.drunkencodepoets.com>
To: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
Message-Id: <20031205082855.137d8f6d.paterley@mail.drunkencodepoets.com>
In-Reply-To: <3FCF25F2.6060008@netzentry.com>
References: <3FCF25F2.6060008@netzentry.com>
Organization: drunkencodepoets.com
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to add my AMD/Nvidia IDE experiences as well as my current nforce2 experience.

Firstly, aside from the forcedeth module vs. nvnet hacked, I have never even known of problems with nforce2 systems.  I have a shuttle mn31/n (micro ATX) and I can use firewire, ide hd running udma5, ide cd running udma2, and the only thing I can do to crash/hang the system is to force unload a module.  It's running apic, lapic, acpi quite happily, no preempt, run every test since around 2.5.75.

noteing that.  I have to run my FSB underclocked by 1 mhz.

my cpu claims to be an xp2400(133/266fsb) but I run it at 132/264.  It was hanging/rebooting due to heat.

my other system (a little off topic here)  is a dual athlon athlon-mp tyan thunder k7 system.  will NOT run with apic and the amd ide driver.

pat erley
