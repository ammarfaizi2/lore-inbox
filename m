Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVDUWau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVDUWau (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 18:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVDUWaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 18:30:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:18154 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261487AbVDUW3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 18:29:25 -0400
Date: Thu, 21 Apr 2005 15:29:19 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Shaun Jackman <sjackman@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netdev watchdog
Message-Id: <20050421152919.34048a4f.rddunlap@osdl.org>
In-Reply-To: <7f45d939050421152171400450@mail.gmail.com>
References: <7f45d939050421152171400450@mail.gmail.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2005 15:21:30 -0700 Shaun Jackman wrote:

| Upon booting my system, the boot fails and the following message is
| displayed repeatedly:
| 
| NETDEV WATCHDOG: eth0: transmit timed out
| eth0: transmit timed out, tx_status 00 status eb01.
| diagnostics: net 0cfa media 88c0 dma 0000003a fifo 0000
| eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
| Flags; bus-master 1, dirty 65(1) current 65(1)
| Transmit list 00000000 vs d0c782a0
| 0: @d0c78200 length 8000002e status 8001002e
| ...
| 
| I also see the same message for eth2. I'd been happily booting this
| 2.6.8.1 kernel for months without trouble. I don't know where this is
| coming from. The drivers for my three NICs are forcedeth, 3c59x, and
| 8139too. I'd be happy to give more information to help.
| 
| Please cc me in your reply. Cheers,
| Shaun

Please see the REPORTING-BUGS file for what info to include
in a bug report.  There's just too much info missing from
this one.

---
~Randy
