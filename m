Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264765AbTCCMHW>; Mon, 3 Mar 2003 07:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264777AbTCCMHV>; Mon, 3 Mar 2003 07:07:21 -0500
Received: from mail5.bluewin.ch ([195.186.1.207]:56972 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id <S264765AbTCCMHU>;
	Mon, 3 Mar 2003 07:07:20 -0500
Date: Mon, 3 Mar 2003 13:17:28 +0100
From: Roger Luethi <rl@hellgate.ch>
To: bert hubert <ahu@ds9a.nl>, Nigel Cunningham <ncunningham@clear.net.nz>,
       Pavel Machek <pavel@ucw.cz>, Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
Message-ID: <20030303121728.GA4048@k3.hellgate.ch>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Nigel Cunningham <ncunningham@clear.net.nz>,
	Pavel Machek <pavel@ucw.cz>, Andrew Grover <andrew.grover@intel.com>,
	ACPI mailing list <acpi-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030226211347.GA14903@elf.ucw.cz> <20030302133138.GA27031@outpost.ds9a.nl> <1046630641.3610.13.camel@laptop-linux.cunninghams> <20030302202118.GA2201@outpost.ds9a.nl> <20030303003940.GA13036@k3.hellgate.ch> <1046657290.8668.33.camel@laptop-linux.cunninghams> <20030303113153.GA18563@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303113153.GA18563@outpost.ds9a.nl>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.63 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Mar 2003 12:31:53 +0100, bert hubert wrote:
> I now use gcc 3.2.2 for compiling though. I've tried suspending a few times
> with 2.5.63bk5 and I get the BUG every time, so it appears to be
> deterministic and not racey.

Yep. It's not the compiler, though. I'm using 2.95.3.

Roger
