Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbTDKJAb (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 05:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbTDKJAb (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 05:00:31 -0400
Received: from 213-4-21-244.uc.nombres.ttd.es ([213.4.21.244]:46835 "EHLO
	mail.flconstruccion.com") by vger.kernel.org with ESMTP
	id S261978AbTDKJA2 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 05:00:28 -0400
Message-ID: <3E96A326.4040700@inicia.es>
Date: Fri, 11 Apr 2003 13:12:38 +0200
From: =?ISO-8859-1?Q?Pablo_Gim=E9nez_Pizarro?= <pablogipi@inicia.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030212 Debian/1.2.1-9woody1
X-Accept-Language: es-es
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Uresolved Symbol problem in kernel compiled for ATHLON :(
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.
I've compiled a kernel optimized for aTHLON processors and when i reboot 
i get the next error nwhen try to load some modules:

/lib/modules/2.4.20/kernel/drivers/net/dmfe.o: unresolved symbol _mmx_memcpy

The next errors are the usual insmod errors in this cases.
I get this unresolved symbol message with other modules like nfs.o, in 
general with net modules and filesystems modules.
If i compile the kernel for a Pentium Pro or lower micro i don't get 
this errors, so i think this is a problem with the ATHLON optimization, 
the kernel version i tried are 2.4.19 and 2.4.20.
I could compile the 2.4.19 for ATHLON in previous times, but now i can't.
Any clue :?

Thanks!!




