Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSD3Tka>; Tue, 30 Apr 2002 15:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314583AbSD3Tk3>; Tue, 30 Apr 2002 15:40:29 -0400
Received: from jane.hollins.EDU ([192.160.94.78]:25868 "EHLO earth.hollins.edu")
	by vger.kernel.org with ESMTP id <S314085AbSD3Tk3>;
	Tue, 30 Apr 2002 15:40:29 -0400
Message-ID: <3CCEF32B.6060807@hollins.edu>
Date: Tue, 30 Apr 2002 15:40:27 -0400
From: "Scott A. Sibert" <kernel@hollins.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020122
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.11 and smbfs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if anyone's mentioned this (I tried searching through the 
recent list archives).  I have 2.5.11 compiled on a dual P3/800 with 
preempt enabled.  smbfs and 3c905c are compiled into the kernel (not 
modules).  It has 1gb memory and I have high memory (4gb) compiled.

I can mount other samba shares fine (ie. Samba-2.2.2 from OSX 10.1.4 and 
Samba-2.2.2 from Tru64 5.1) and the directories look fine.  When I mount 
a share from a Windows 2000 server I only get the first letter of the 
entry in the shared folder which, of course, makes no sense and 
generates errors when just trying to get an "ls" of the share.  The 
Win2K servers are both regular server and Adv Server, both with SP2 and 
the latest patches.  The linux machine is running RedHat 7.2 with almost 
all of the latest updates and 2.5.11 compiled.

Please let me know if there is any other information needed or if you 
want me to try something.  (I will try to respond quickly.)

--Scott


