Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267630AbTAHA71>; Tue, 7 Jan 2003 19:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267625AbTAHA71>; Tue, 7 Jan 2003 19:59:27 -0500
Received: from bitmover.com ([192.132.92.2]:10943 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267630AbTAHA7Z>;
	Tue, 7 Jan 2003 19:59:25 -0500
Date: Tue, 7 Jan 2003 17:08:04 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Andre Hedrick <andre@pyxtechnologies.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Message-ID: <20030108010804.GH6249@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Roman Zippel <zippel@linux-m68k.org>,
	Andre Hedrick <andre@pyxtechnologies.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.10.10301071439190.421-100000@master.linux-ide.org> <3E1B6B23.40A3C939@linux-m68k.org> <1041990181.22457.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041990181.22457.9.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 01:43:01AM +0000, Alan Cox wrote:
> On Wed, 2003-01-08 at 00:04, Roman Zippel wrote:
> > If you want to compare apples with apples, you should rather tell me how
> > I turn off the checksumming of my nic.
> 
> For some cards you can do this. For instructive information on the effects 
> look at the saga of sunos 3.x and NFS over wans. Old SunOS turned off UDP
> checksums for NFS. It provided an adequate demonstration that UDP checksums
> for NFS are needed. Sun of course addressed this design error long long 
> ago.

BK has a pretty lame checksum but good enough to catch a lot of errors
and we still catch 'em.  Software, hardware, network, whatever, they
happen all the time.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
