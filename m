Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265687AbTCCP1K>; Mon, 3 Mar 2003 10:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbTCCP1K>; Mon, 3 Mar 2003 10:27:10 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46235
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265687AbTCCP1I>; Mon, 3 Mar 2003 10:27:08 -0500
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: bert hubert <ahu@ds9a.nl>
Cc: Pavel Machek <pavel@suse.cz>, Nigel Cunningham <ncunningham@clear.net.nz>,
       Roger Luethi <rl@hellgate.ch>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030303151135.GA24815@outpost.ds9a.nl>
References: <20030226211347.GA14903@elf.ucw.cz>
	 <20030302133138.GA27031@outpost.ds9a.nl>
	 <1046630641.3610.13.camel@laptop-linux.cunninghams>
	 <20030302202118.GA2201@outpost.ds9a.nl>
	 <20030303003940.GA13036@k3.hellgate.ch>
	 <1046657290.8668.33.camel@laptop-linux.cunninghams>
	 <20030303113153.GA18563@outpost.ds9a.nl>
	 <20030303122325.GA20929@atrey.karlin.mff.cuni.cz>
	 <20030303123551.GA19859@outpost.ds9a.nl>
	 <20030303124133.GH20929@atrey.karlin.mff.cuni.cz>
	 <20030303151135.GA24815@outpost.ds9a.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046709619.6530.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Mar 2003 16:40:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 15:11, bert hubert wrote:
> To no avail. I'm investigating how I can go ext2 on this machine as I read
> elsewhere that the kernel will silently mount an ext3 partition with a
> journal as ext3 even when asked to mount as ext2.

hdparm -u1 is just changing the timing its not actually touching the bug in
the suspend code.

