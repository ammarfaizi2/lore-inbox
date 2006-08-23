Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWHWMsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWHWMsW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 08:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWHWMsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 08:48:22 -0400
Received: from asp.isprit2.de ([213.221.110.57]:22401 "EHLO
	prod-tx-2.isprit2.de") by vger.kernel.org with ESMTP
	id S932448AbWHWMsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 08:48:21 -0400
Message-ID: <44EC4EE2.6060701@xqueue.de>
Date: Wed, 23 Aug 2006 14:49:38 +0200
From: =?ISO-8859-15?Q?Bj=F6rn_Engelhardt?= <bjoern2@xqueue.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.17.8 on Quad AMD Opteron 852 with 16x 4GB Modules (64GB
 RAM)
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

we upgraded a Server from 32 GB RAM to 64 GB. Now we try to get a Linux 
(FC5) with kernel 2.6.17.8 on a Quad Opteron (852; 64bit)-system with 
16x 4GB modules to run.
With 32 GB (8x 4GB modules) the system starts without any problems, but 
above I get kernelpanics.
The output then gives me several memoryaddresses bevore the panic 
appears. The board (a Tyan K8QW,model S4881) should support up to 64GB 
Ram. A Memorytest under Linux recognizes the 64GB and continues without 
an error.
I tried several BIOS-Settings.
Does the kernel support the new 4GB-Modules by 64GB Ram?

Thanks for every help, I have no more ideas in the moment

Regards
    Björn Engelhardt

PS: Sorry for my bad english
