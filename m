Return-Path: <linux-kernel-owner+w=401wt.eu-S1751059AbXANO6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbXANO6V (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 09:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbXANO6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 09:58:21 -0500
Received: from ppp-70-251-6-36.dsl.rcsntx.swbell.net ([70.251.6.36]:39017 "EHLO
	server.willdawg" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751059AbXANO6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 09:58:21 -0500
X-Greylist: delayed 1792 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jan 2007 09:58:20 EST
Date: Sun, 14 Jan 2007 14:28:26 +0000 (GMT)
From: icxcnika@mar.tar.cc
X-X-Sender: icxcnika@server.willdawg
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.20-rc5
Message-ID: <Pine.LNX.4.64.0701141426220.12877@server.willdawg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In compiling:
   CC [M]  net/ipv4/netfilter/ipt_TTL.o
   LD [M]  drivers/usb/storage/usb-storage.o
   CC [M]  drivers/usb/gadget/net2280.o
   CC [M]  net/ipv4/netfilter/arp_tables.o
drivers/usb/gadget/net2280.c: In function 'net2280_probe':
drivers/usb/gadget/net2280.c:2969: warning: ignoring return value of 
'pci_set_mwi', declared with attribute warn_unused_result
--
   CC [M]  net/netfilter/xt_tcpmss.o
   CC [M]  net/netfilter/xt_hashlimit.o
   LD [M]  net/netfilter/nf_conntrack.o
   Building modules, stage 2.
   MODPOST 239 modules
WARNING: "__ucmpdi2" [drivers/media/video/v4l2-common.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

If a .config is needed or any other information, I'd be happy to provide 
it.

Please CC a reply to my email.
William Heimbigner
icxcnika@mar.tar.cc
