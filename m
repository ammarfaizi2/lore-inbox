Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267634AbTAHAtU>; Tue, 7 Jan 2003 19:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267636AbTAHAtU>; Tue, 7 Jan 2003 19:49:20 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:23945
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267634AbTAHAtT>; Tue, 7 Jan 2003 19:49:19 -0500
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andre Hedrick <andre@pyxtechnologies.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E1B6B23.40A3C939@linux-m68k.org>
References: <Pine.LNX.4.10.10301071439190.421-100000@master.linux-ide.org>
	 <3E1B6B23.40A3C939@linux-m68k.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041990181.22457.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 08 Jan 2003 01:43:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-08 at 00:04, Roman Zippel wrote:
> If you want to compare apples with apples, you should rather tell me how
> I turn off the checksumming of my nic.

For some cards you can do this. For instructive information on the effects 
look at the saga of sunos 3.x and NFS over wans. Old SunOS turned off UDP
checksums for NFS. It provided an adequate demonstration that UDP checksums
for NFS are needed. Sun of course addressed this design error long long 
ago.


