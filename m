Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUCLLWW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 06:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbUCLLWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 06:22:22 -0500
Received: from mail.unionbank.bg ([213.91.171.2]:27058 "HELO mail.unionbank.bg")
	by vger.kernel.org with SMTP id S261812AbUCLLWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 06:22:21 -0500
Message-ID: <40519D68.6010809@unionbank.bg>
Date: Fri, 12 Mar 2004 13:22:16 +0200
From: Cvetan Grigorov <GrigorovC@unionbank.bg>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, ctapir@abv.bg
Subject: Kernel 2.4.25   __alloc_pages: 3-order allocation failed
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have Debian  Linux with precompiled kernel 2.4.25. My box is with IDE 
RIDE (Highpoint)
The heaviest process, that I have is squid-cache. Its cache is about 1.7 
GB and cause good CPU and memory load.
The problem is that I start to receive the fallowing error in my logs:

__alloc_pages: 3-order allocation failed (gfp=0x20/0)
__alloc_pages: 3-order allocation failed (gfp=0x20/0)
__alloc_pages: 3-order allocation failed (gfp=0x20/0)
__alloc_pages: 3-order allocation failed (gfp=0x20/0)
__alloc_pages: 3-order allocation failed (gfp=0x20/0)
__alloc_pages: 3-order allocation failed (gfp=0x20/0)

I read some posts for this error for kernel up to  2.4.11, but I haven't 
SCSI nor USB. I can't understand what cause this error.

I dont't know if I have some phisical problem with my memory or disks.

I'm not in list so please answer me directly.
