Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279907AbRKJEXj>; Fri, 9 Nov 2001 23:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280433AbRKJEX2>; Fri, 9 Nov 2001 23:23:28 -0500
Received: from f133.law10.hotmail.com ([64.4.15.133]:26126 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S279907AbRKJEXM>;
	Fri, 9 Nov 2001 23:23:12 -0500
X-Originating-IP: [129.186.3.166]
From: "Femitha Majeed" <m_femitha@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: m_femitha@hotmail.com
Subject: Unable to handle kernel paging request at virtual address....
Date: Sat, 10 Nov 2001 04:23:03 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F1336POYFSrAuWiqJmd000226c0@hotmail.com>
X-OriginalArrivalTime: 10 Nov 2001 04:23:06.0811 (UTC) FILETIME=[6595B0B0:01C1699F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to write a kernel module which reads the files in the /proc 
directory.

When I do an insmod filename.o, I get the following error:
Unable to handle kernel paging request at virtual address....

In the module, I use kmalloc to allocate memory. Is that the reason I am 
getting this error?

I am very new to writing kernel modules, I would really appreciate a reply.

Thanks,
Femitha Majeed

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

