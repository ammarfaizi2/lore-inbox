Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266796AbTCCQSZ>; Mon, 3 Mar 2003 11:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266868AbTCCQSZ>; Mon, 3 Mar 2003 11:18:25 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:4564 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S266796AbTCCQSC>;
	Mon, 3 Mar 2003 11:18:02 -0500
Date: Mon, 3 Mar 2003 17:28:29 +0100
From: bert hubert <ahu@ds9a.nl>
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>, Roger Luethi <rl@hellgate.ch>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
Message-ID: <20030303162829.GA26286@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Pavel Machek <pavel@suse.cz>,
	Nigel Cunningham <ncunningham@clear.net.nz>,
	Roger Luethi <rl@hellgate.ch>,
	ACPI mailing list <acpi-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030226211347.GA14903@elf.ucw.cz> <20030302133138.GA27031@outpost.ds9a.nl> <1046630641.3610.13.camel@laptop-linux.cunninghams> <20030302202118.GA2201@outpost.ds9a.nl> <20030303003940.GA13036@k3.hellgate.ch> <1046657290.8668.33.camel@laptop-linux.cunninghams> <20030303113153.GA18563@outpost.ds9a.nl> <20030303122325.GA20929@atrey.karlin.mff.cuni.cz> <20030303123551.GA19859@outpost.ds9a.nl> <20030303124133.GH20929@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303124133.GH20929@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 01:41:33PM +0100, Pavel Machek wrote:

> Start adding printks to see whats going on. Try going ext2. Try
> killing sys_sync() from kernel/suspend.c.

Problem remains with ext2 and with all fs 'emergency mounted r/o' with
alt-sysrq beforehand.

This mostly ends my ability to debug this problem further as I lack the
knowledge to figure out what is going on within the IDE code.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
