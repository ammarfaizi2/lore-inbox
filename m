Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269174AbRHFXWe>; Mon, 6 Aug 2001 19:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269177AbRHFXWY>; Mon, 6 Aug 2001 19:22:24 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12808 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269174AbRHFXWN>; Mon, 6 Aug 2001 19:22:13 -0400
Subject: Re: Virtual memory error when restarting X
To: sitsofe@my-deja.com (Sitsofe Wheeler)
Date: Tue, 7 Aug 2001 00:23:50 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Sitsofe Wheeler" at Aug 06, 2001 03:45:18 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Ttiw-0001yz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Often after restarting X I see the messages similar to "NV0: still have vm que at nv_close(): 0x4023b000 to 0x40245000" in the logs. I presume that these are being caused by the properitry nvidia drivers that I use with X. However I have also noticed that "Unable to handle kernel paging request at virtual address 6b336b50" and the like have also been turning up. I'm wondering whether the graphics drivers problems could be being caused by a vm problem. The oops that
> is enclosed does not appear to be readily repeatable...  but leaving X causes sometimes the system to lock solid with only SysRq getting through. 

Talk to Nvidia. Its their obfuscated/binary driver set, nobody else can help
you fix it.

Alan


