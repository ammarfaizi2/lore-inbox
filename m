Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264761AbTCCMZ0>; Mon, 3 Mar 2003 07:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbTCCMZ0>; Mon, 3 Mar 2003 07:25:26 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:32681 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S264761AbTCCMZZ>;
	Mon, 3 Mar 2003 07:25:25 -0500
Date: Mon, 3 Mar 2003 13:35:51 +0100
From: bert hubert <ahu@ds9a.nl>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>, Roger Luethi <rl@hellgate.ch>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
Message-ID: <20030303123551.GA19859@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Pavel Machek <pavel@ucw.cz>,
	Nigel Cunningham <ncunningham@clear.net.nz>,
	Roger Luethi <rl@hellgate.ch>,
	ACPI mailing list <acpi-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030226211347.GA14903@elf.ucw.cz> <20030302133138.GA27031@outpost.ds9a.nl> <1046630641.3610.13.camel@laptop-linux.cunninghams> <20030302202118.GA2201@outpost.ds9a.nl> <20030303003940.GA13036@k3.hellgate.ch> <1046657290.8668.33.camel@laptop-linux.cunninghams> <20030303113153.GA18563@outpost.ds9a.nl> <20030303122325.GA20929@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303122325.GA20929@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ pruned mr Grover from the CC list ]

On Mon, Mar 03, 2003 at 01:23:25PM +0100, Pavel Machek wrote:
> Well, it does not happen on my machines, but I've already seen it
> happen on computer with two harddrives.

This is a laptop with only one. Anything I can do to help, let me know. Alan
has suggested that an IDE transaction was still in progress, perhaps a small
wait could prove/disprove this assumption?

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
