Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVBXGdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVBXGdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 01:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVBXGb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 01:31:57 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:1995 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S261855AbVBXGYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 01:24:54 -0500
From: Michael Neuffer <neuffer@neuffer.info>
Date: Thu, 24 Feb 2005 07:24:55 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc5
Message-ID: <20050224062454.GA9972@neuffer.info>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Torvalds (torvalds@osdl.org):
> 
> 
> Hey, I hoped -rc4 was the last one, but we had some laptop resource
> conflicts, various ppc TLB flush issues, some possible stack overflows in
> networking and a number of other details warranting a quick -rc5 before
> the final 2.6.11.
> 
> This time it's really supposed to be a quickie, so people who can, please 
> check it out, and we'll make the real 2.6.11 asap.
> 
> Mostly pretty small changes (the largest is a new SATA driver that crept
> in, our bad). But worth another quick round.


Are you sure you uploaded the correct patch file ?



-rw-rw-r--    1 536      536         50907 Feb 24 04:13 ChangeLog-2.6.11-rc5
-rw-rw-r--    1 536      536             0 Feb 24 04:13 LATEST-IS-2.6.11-rc5
-rw-rw-r--    1 536      536      46586159 Feb 24 04:20 linux-2.6.11-rc5.tar.gz
-rw-rw-r--    1 536      536           248 Feb 24 04:20 linux-2.6.11-rc5.tar.gz.sign
-rw-rw-r--    1 536      536            37 Feb 24 04:20 patch-2.6.11-rc5.gz
-rw-rw-r--    1 536      536      37080033 Feb 24 04:20 linux-2.6.11-rc5.tar.bz2
-rw-rw-r--    1 536      536           248 Feb 24 04:20 linux-2.6.11-rc5.tar.bz2.sign
-rw-rw-r--    1 536      536           248 Feb 24 04:20 linux-2.6.11-rc5.tar.sign
-rw-rw-r--    1 536      536            14 Feb 24 04:20 patch-2.6.11-rc5.bz2
-rw-rw-r--    1 536      536           248 Feb 24 04:20 patch-2.6.11-rc5.bz2.sign
-rw-rw-r--    1 536      536           248 Feb 24 04:20 patch-2.6.11-rc5.gz.sign
-rw-rw-r--    1 536      536           248 Feb 24 04:20 patch-2.6.11-rc5.sign
drwxrwsr-x    2 536      536          8192 Feb 24 04:57 incr
drwxrwsr-x    4 536      536         16384 Feb 24 05:00 .
lftp ftp.kernel.org:/pub/linux/kernel/v2.6/testing> 


Cheers
   Mike
