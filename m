Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbTH2N2Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 09:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTH2N2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 09:28:24 -0400
Received: from kiuru.kpnet.fi ([193.184.122.21]:52190 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S261284AbTH2N2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 09:28:23 -0400
Message-ID: <3F4F54F2.4080506@ihme.org>
Date: Fri, 29 Aug 2003 16:28:18 +0300
From: =?ISO-8859-1?Q?Markus_H=E4stbacka?= <midian@ihme.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en, fi
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Weird problem with nforce2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I just bought a new motherboard, CPU and RAM. With the last computer 
everything worked fine under 2.4 and 2.6. Now it's not that way any 
more. I can run 2.4.22, but it's slow (All of 2.4 series kernel's I 
tested seem to be slow), then I hooked up 2.6.0-test4, booted, 
everything looked fine, but then when I tryed to install NVIDIA drivers, 
I get many errors about nv_kern_read_agpinfo, yes, I tested 
2.6.0-test1-3 too, but when I boot the IRQ #19 get's some errors, but in 
2.6.0-test4 no errors in boot, but I can't compile nvidia card drivers! 
This may be off-topic, but I think this is the best way for getting 
help. (Yes, I patched nvidia_kernel too, so it's not about that, and the 
same package worked on old computer really well, with the same graphic 
card). My chipset is NForce2, and needs NVIDIA NForce/NForce2 so the agp 
can work with full power. Thank you.

