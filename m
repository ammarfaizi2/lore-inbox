Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271958AbRH2NAV>; Wed, 29 Aug 2001 09:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271960AbRH2NAK>; Wed, 29 Aug 2001 09:00:10 -0400
Received: from CPE-203-45-215-234.qld.bigpond.net.au ([203.45.215.234]:28561
	"EHLO monkeyiq.dnsalias.org") by vger.kernel.org with ESMTP
	id <S271958AbRH2M7y>; Wed, 29 Aug 2001 08:59:54 -0400
Date: Wed, 29 Aug 2001 23:00:05 +1000
Message-Id: <200108291300.f7TD05T01627@monkeyiq.dnsalias.org>
To: linux-kernel@vger.kernel.org
Cc: monkeyiq@users.sourceforge.net
Subject: Keeping the 'cached' memory under control
From: monkeyiq <monkeyiq@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Please CC me as Im not on the list atm.

  I had moved from using 2.4.5 to using the Alan Cox tree but
had recently moved back to raw 2.4.9. In doing this I noticed
that the VM in the Linus standard tree seems to chomp heaps of
RAM for cache and not give it back. This is a very painful 
thing having 200Mb showing in free as cached and 150Mb in swap,
with 4Mb free. It means that I must play games to get enough RAM
free to play a DVD without jerkyness of paging. 

  To keep this email short, I want to play with XFS and I want to
have a machine that is not paging whenever I move the mouse, If
anyone knows of patches for XFS for recent ac kernels I'l love to 
know. And if anyone has info on tuneing the VM to not hoard all the
memory in standard trees I'd like to know.

  Also my special internet keys didn't work on the ac tree from my
USB keyboard but using the same .config work fine in 2.4.9 anyone
experienced a similar thing? This is with vmlinuz-2.4.7-ac9 and some
2.4.8-ac kernels that I've tried.

Thanks, and sorry if these are pesky FAQs, but I couldn't find much
in the archive search about these, well, the first two anyway :/.
 
-----------------------------------------------------
Does your browser suck?
http://witme.sourceforge.net/libferris.web/

