Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143367AbREKTFs>; Fri, 11 May 2001 15:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143366AbREKTFj>; Fri, 11 May 2001 15:05:39 -0400
Received: from chiark.greenend.org.uk ([195.224.76.132]:27396 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S143363AbREKTFc>; Fri, 11 May 2001 15:05:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15100.14331.266307.985883@chiark.greenend.org.uk>
Date: Fri, 11 May 2001 20:05:31 +0100 (BST)
From: Chris Emerson <cemerson@chiark.greenend.org.uk>
To: linux-kernel@vger.kernel.org
Subject: User-mode Linux ported to ppc
X-Mailer: VM 6.75 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

User-mode Linux is now booting on PPC Linux - it can boot with a
Debian root floppy image with init=/bin/sh and poke around.  It mostly
works, although there are still a few problems.

The current patch is available from
http://www.tartarus.org/~chris/user-mode-linux/, made against recent
UML CVS (see http://user-mode-linux.sourceforge.net).

Cheers,

Chris
-- 
Chris Emerson, obsessed Cambridge juggler
E-mail: cemerson@chiark.greenend.org.uk
Web page: http://www.chiark.greenend.org.uk/~cemerson/
