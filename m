Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbTAEHiT>; Sun, 5 Jan 2003 02:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbTAEHiS>; Sun, 5 Jan 2003 02:38:18 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:1284
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S263342AbTAEHiS>; Sun, 5 Jan 2003 02:38:18 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
Date: Sun, 5 Jan 2003 02:47:57 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Binary drivers and GPL
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200301050247.57845.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enough is enough! I'm SO tired of hearing this over and over now. But since 
it's raging on I might as well throw some coal into the fire a little ;-)

As much as I would love to see a ban on binary drivers to protect the kernel, 
this issue isn't going away. Not only that but I'd love to see a module 
blacklist in which a non-tainted kernel refuses to load binary drivers that 
are not GPL.

We have to make sure that we restrict binary drivers as much as possible 
because other companies may decide that they don't need to release their 
specs/sources anymore because binary drivers become the norm and because 
their competition is also not releasing their specs/code. This I fear is the 
danger if we go down this road. We can't allow companies to dictate 
indirectly how a kernel will function. 

Shawn.



