Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbTI0Mz5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 08:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbTI0Mz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 08:55:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:62172 "EHLO
	VL-MO-MR005.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S262436AbTI0Mz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 08:55:56 -0400
Date: Sat, 27 Sep 2003 08:45:56 -0400
From: Jean-Marc Spaggiari <Jean-Marc@Spaggiari.org>
Subject: Kernel panic:Unable to mount root fs (2.6.0-test5)
To: linux-kernel@vger.kernel.org
Message-id: <3F758684.8000001@Spaggiari.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: fr-fr, fr-ca, fr-be, fr-lu, fr-mc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(as you can see, i'm a newbie of english speeking, and linux-kernel 
posting, so, excuse me if this is a duplicate contribution, I have 
search on the web and on the archive and fine nothing about this error.)


Error message :
VFS : Cannot open root device "302" or unknown-block(3,2)
Please append a corect "root=" boot option
Kernel panic: VFS: Unable to mount root fs on unknown-block(3,2)


Kernel version : 2.6.0-test5

System : Toshiba Satellite laptop

More information : Linux is installe on /deh/hda2. There 2 other kernel 
on this computer. A 2.2.20 and a 2.4.22, both of them working fine. Ia 
have try many differend option for compile the kernel, but never working 
any more. My /dev/hda2 is on ext3.

I will try soon on my other systems.

I will be hapy if I can help in any kind, so, at this time, i'm going 
back to 2.4.22. (Need I to poste my .config here ?)

Regards,

Jean-Marc Spaggiari (QC.CA)

