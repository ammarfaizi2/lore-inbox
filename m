Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266274AbTBKVE7>; Tue, 11 Feb 2003 16:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266292AbTBKVE6>; Tue, 11 Feb 2003 16:04:58 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9088
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266274AbTBKVE2>; Tue, 11 Feb 2003 16:04:28 -0500
Subject: Re: via rhine bug? (timeouts and resets)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Henrik Persson <nix@socialism.nu>
Cc: Gianni Tedesco <gianni@ecsc.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200302111434.h1BEYiPY067260@sirius.nix.badanka.com>
References: <200302111344.h1BDiMPY067070@sirius.nix.badanka.com>
	 <1044973108.1118.89.camel@lemsip>
	 <200302111434.h1BEYiPY067260@sirius.nix.badanka.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044981891.13931.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 11 Feb 2003 16:44:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-11 at 14:34, Henrik Persson wrote:
> On 11 Feb 2003 14:18:28 +0000
> Gianni Tedesco <gianni@ecsc.co.uk> wrote:
> 
> GT> On Tue, 2003-02-11 at 13:43, Henrik Persson wrote:
> GT> > The problem is that my Via Rhine-NIC when transmitting alot of data fast
> GT> > (like.. ftp:ing large files over the network at 100mbit/s) gets an error
> GT> > (frame dropped, transmit error, reset).. As a cause of this the speed
> GT> > drops to about 3-4MB/s and the rest of the communication trough the
> GT> > network isn't working very well..
> GT> > 
> GT> > Note that this ONLY happens when there's alot of traffic (i.e. speeds at
> GT> > ~100mbit/s)..
> GT> 
> GT> Have you tried connecting directly to the other device with a crossover
> GT> cable, do problems still occur?

I have two EPIA-M boards, one does this and is really touchy about cables
the other is quite reliable. If you use a different via-rhine does it work
any better. I'm wondering if there are some dud phy's around on the via stuff

