Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275210AbRJAQVc>; Mon, 1 Oct 2001 12:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275211AbRJAQVV>; Mon, 1 Oct 2001 12:21:21 -0400
Received: from relay.swspn.net.au ([203.87.88.2]:19219 "EHLO
	relay.swspn.net.au") by vger.kernel.org with ESMTP
	id <S275210AbRJAQVN>; Mon, 1 Oct 2001 12:21:13 -0400
Message-Id: <4.3.2.7.2.20011002021641.02340710@mail.ispdr.net.au>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 02 Oct 2001 02:25:12 +1000
To: linux-kernel@vger.kernel.org
From: Anthony <aslan@ispdr.net.au>
Subject: Patch files
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
	I'm new to this list, and have been using Linux for just over a year now. 
I'll get straight to the point, as I think this may be a bit off-topic. I'm 
trying to apply a patch file to support a PCI printer card I've got. The 
patch file contains several patches, but only the last one is working. I'm 
prepared to try and sort it out myself, but I just need to know something 
about the patch file so I might be able to understand how it works. Can 
anyone please explain (or point me to the relevant documentation) to me 
what the following lines mean?:

--- linux/include/linux/pci_ids.h.netmos	Sat Sep  8 09:44:43 2001
+++ linux/include/linux/pci_ids.h	Sat Sep  8 09:44:45 2001
@@ -1664,8 +1664,12 @@

And this is from further down in the patch:
@@ -2831,6 +2839,15 @@

I'm using RedHat 7.1 with the included 2.4.2-2 kernel. Any help on this 
matter would be much appreciated.


----------------------------
Anthony (aslan@ispdr.net.au)
----------------------------

