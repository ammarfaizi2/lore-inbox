Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267155AbSIRQCm>; Wed, 18 Sep 2002 12:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbSIRQCm>; Wed, 18 Sep 2002 12:02:42 -0400
Received: from dexter.citi.umich.edu ([141.211.133.33]:4224 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S267155AbSIRQCl>; Wed, 18 Sep 2002 12:02:41 -0400
Date: Wed, 18 Sep 2002 12:07:42 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] vmlinux.lds.S missing newline at EOF (2.5.36)
Message-ID: <Pine.LNX.4.44.0209181205290.11780-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Linus-

noted in 2.5.36 -- "vmlinux.lds.S" for following 3 architectures is
missing a newline at the end of these files:

  arch/m68k/vmlinux.lds.S
  arch/s390/vmlinux.lds.S
  arch/s390x/vmlinux.lds.S

-- 

corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

