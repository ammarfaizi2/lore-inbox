Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131413AbRCWUMv>; Fri, 23 Mar 2001 15:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131414AbRCWUMo>; Fri, 23 Mar 2001 15:12:44 -0500
Received: from [213.97.184.209] ([213.97.184.209]:3456 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S131413AbRCWULy>;
	Fri, 23 Mar 2001 15:11:54 -0500
Date: Fri, 23 Mar 2001 21:10:31 +0100 (CET)
From: German Gomez Garcia <german@piraos.com>
To: dri-devel@lists.sourceforge.net
cc: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Problems with latest changes in kernel and X
Message-ID: <Pine.LNX.4.21.0103232104590.306-100000@hal9000.piraos.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	After upgrading to latest 2.4.2-ac23 (that includes latest changes
from 2.4.3-pre6) X doesn't start anymore. It was working perfectly for
2.4.2-ac20. I'm using DRI CVS, but it seems to have little to do with DRI
as disabling completely DRI doesn't help. 
	
	After starting X the system hangs up, the screen goes black but it
keep syncro, no way to kill or restore the original console although
SysRq boot still works. I'm going back to ac20, if you need more info I
could test other kernels (ac21, ac22).

	Regards,

	- german

PS: I'm running SMP kernel on dual PII450 on a P6DBU Supermicro board (BX
chipset).
-------------------------------------------------------------------------
German Gomez Garcia         | "This isn't right.  This isn't even wrong."
<german@piraos.com>         |                         -- Wolfgang Pauli

