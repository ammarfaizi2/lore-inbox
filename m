Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316192AbSFUCW1>; Thu, 20 Jun 2002 22:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316185AbSFUCW1>; Thu, 20 Jun 2002 22:22:27 -0400
Received: from naur.csee.wvu.edu ([157.182.194.28]:24045 "EHLO
	naur.csee.wvu.edu") by vger.kernel.org with ESMTP
	id <S316182AbSFUCW0>; Thu, 20 Jun 2002 22:22:26 -0400
Subject: Reg. Sparc64 checksum.S
From: Shanti Katta <katta@csee.wvu.edu>
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 Jun 2002 22:27:19 -0400
Message-Id: <1024626440.2720.19.camel@indus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am trying to build user-mode-linux binaries for sparc64 architecture.
I am running a debian (sid) system. Now, I made some sparc64 specific
changes to uml code like TASK_UNMAPPED_BASE and SPARC_FLAG_32BIT. 
When I try to "make vmlinux", I get the following error:

checksum.S:513: Fatal error: checksum.S:97: bad return from
bfd_install_relocation

I tried searching for this error, but couldn't get any help. Is there
any documentation where I can look for possible reasons for different
kinds of Sparc64 compilation errors? 
I am not subscribed to the mailing list, so please CC me. Any pointers
would be appreciated.

Thank you
-Regards
-Shanti



