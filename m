Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284235AbRLAUX2>; Sat, 1 Dec 2001 15:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284237AbRLAUXI>; Sat, 1 Dec 2001 15:23:08 -0500
Received: from host213-121-104-31.in-addr.btopenworld.com ([213.121.104.31]:44760
	"HELO mail.dark.lan") by vger.kernel.org with SMTP
	id <S284235AbRLAUXA>; Sat, 1 Dec 2001 15:23:00 -0500
Subject: Security issues in 2.4.9 and beyond
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 01 Dec 2001 20:22:06 +0000
Message-Id: <1007238127.2475.0.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I am putting together a database of errata for Linux 2.4.x. It will have
individual patches for each major bug (at the moment thats just security
flaws) and a mega-patch for each version. I am starting on kernel 2.4.9
for no other reason as this is what I currently use...

This is what I have so far for 2.4.9:
1. Netfilter mac address matching bug
2. ptrace race condition
3. symlink DoS
4. syncookie/netfilter bug
5. Netfilter FTP conntrack bug (can someone confirm this ??)

I have patches only for item 1 at the moment. I can rip out the patch
for 3 and possibly 4. If there is interest I will post a URL to them
here.

Does anyone here know of any other issues in this kernel (or newer
kernels) or have access to any of the patches I am missing? You can mail
patches to me directly if they are big or you feel they are irrelivant
to the list.

Thanks

-- 
// Gianni Tedesco <gianni@ecsc.co.uk>
80% of all email is a figment of procmails imagination.

