Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264207AbTEXAFL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 20:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbTEXAFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 20:05:11 -0400
Received: from aneto.able.es ([212.97.163.22]:43466 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S264207AbTEXAFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 20:05:10 -0400
Date: Sat, 24 May 2003 02:18:15 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Sven Krohlas <darkshadow@web.de>
Cc: Oliver Pitzeier <o.pitzeier@uptime.at>, marcelo@conectiva.com.br,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
Message-ID: <20030524001815.GA2563@werewolf.able.es>
References: <002c01c32108$1e4bb980$020b10ac@pitzeier.priv.at> <3ECDE94C.3030502@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.23, Sven Krohlas wrote:
> Hi,
> 
> > OK. So now I have to say: _Don't_ use 2.4.20-rc* if you have a aic7xxx. You can
> > use 2.4.19 and maybe 2.4.20(?).
> 
> Just to clearify: _I don't_ have a aic7xxx!
> 

And just to mess it more, I _do have_ an aic7xxx, and aic-20030520 works fine
for me.
00:0e.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891 (rev 01)
        Subsystem: Adaptec 2940U2W SCSI Controller
        Flags: bus master, medium devsel, latency 64, IRQ 10
        BIST result: 00
        I/O ports at e800 [disabled] [size=256]
        Memory at febff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at febc0000 [disabled] [size=128K]
        Capabilities: <available only to root>

Using http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.21-rc3-jam1.tar.gz
(and previous).

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc3-jam1 (gcc 3.2.3 (Mandrake Linux 9.2 3.2.3-1mdk))
