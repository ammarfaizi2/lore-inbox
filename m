Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130454AbRCIJDE>; Fri, 9 Mar 2001 04:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130457AbRCIJCy>; Fri, 9 Mar 2001 04:02:54 -0500
Received: from [210.77.38.126] ([210.77.38.126]:21518 "EHLO
	ns.turbolinux.com.cn") by vger.kernel.org with ESMTP
	id <S130454AbRCIJCj>; Fri, 9 Mar 2001 04:02:39 -0500
Date: Fri, 9 Mar 2001 17:03:38 +0800
From: michaelc <michaelc@turbolinux.com.cn>
X-Mailer: The Bat! (v1.49) UNREG / CD5BF9353B3B7091
Reply-To: michaelc <michaelc@turbolinux.com.cn>
X-Priority: 3 (Normal)
Message-ID: <865464921.20010309170338@turbolinux.com.cn>
To: linux-kernel@vger.kernel.org
Subject: about PENTIUM4 cache line
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
     I read the Intel IA-32 developer's manual recently, and I found
 the cache lines for L1 and L2 caches in Pentium4 are 64 bytes
 wide, but the thing make me confused is that the default value
 CONFIG_X86_L1_CACHE_SHIFT option in 2.4.x kernel is 7, why it's
 not 6?   Any expanation about this would be appreciated!
    

  

-- 
Best regards,
Michael Chen                          mailto:michaelc@turbolinux.com.cn


