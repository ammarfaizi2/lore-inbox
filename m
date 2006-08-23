Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWHWPv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWHWPv4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWHWPvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:51:55 -0400
Received: from terminus.zytor.com ([192.83.249.54]:61620 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964996AbWHWPvz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:51:55 -0400
Message-ID: <44EC798F.2080108@zytor.com>
Date: Wed, 23 Aug 2006 08:51:43 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Bj=F6rn_Engelhardt?= <bjoern2@xqueue.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.17.8 on Quad AMD Opteron 852 with 16x 4GB Modules
 (64GB RAM)
References: <44EC4EE2.6060701@xqueue.de>
In-Reply-To: <44EC4EE2.6060701@xqueue.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Björn Engelhardt wrote:
> Hello,
> 
> we upgraded a Server from 32 GB RAM to 64 GB. Now we try to get a Linux 
> (FC5) with kernel 2.6.17.8 on a Quad Opteron (852; 64bit)-system with 
> 16x 4GB modules to run.
> With 32 GB (8x 4GB modules) the system starts without any problems, but 
> above I get kernelpanics.
> The output then gives me several memoryaddresses bevore the panic 
> appears. The board (a Tyan K8QW,model S4881) should support up to 64GB 
> Ram. A Memorytest under Linux recognizes the 64GB and continues without 
> an error.
> I tried several BIOS-Settings.
> Does the kernel support the new 4GB-Modules by 64GB Ram?
> 

Sounds like your memory is bad.

	-hpa
