Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315548AbSEWBCU>; Wed, 22 May 2002 21:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315544AbSEWBCT>; Wed, 22 May 2002 21:02:19 -0400
Received: from naur.csee.wvu.edu ([157.182.194.28]:54184 "EHLO
	naur.csee.wvu.edu") by vger.kernel.org with ESMTP
	id <S315529AbSEWBCR>; Wed, 22 May 2002 21:02:17 -0400
Subject: Reg. asm-sparc64/processor.h
From: Shanti Katta <katta@csee.wvu.edu>
To: davem@redhat.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 22 May 2002 21:04:57 -0400
Message-Id: <1022115898.1418.14.camel@indus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am trying to port User-mode-linux to Sparc64 architecture. I have the
debian(sid) on my host system with custom built 2.4.18 kernel. When I
try to generate some header file for UML that #included
<asm-sparc64/processor.h> file, I was getting parse errors for u64 data
types. When I changed all those U64 data-types to __u64 type, it fixed
the error. So, I was just wondering, whether it is the right thing to
do.

-Thanks in advance
-Shanti Katta



