Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSEPFNJ>; Thu, 16 May 2002 01:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316579AbSEPFNI>; Thu, 16 May 2002 01:13:08 -0400
Received: from zok.SGI.COM ([204.94.215.101]:63910 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316578AbSEPFNH>;
	Thu, 16 May 2002 01:13:07 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.2.21-rc4 contains generated files
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 16 May 2002 15:12:57 +1000
Message-ID: <30467.1021525977@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.2.21-rc4 contains arch/i386/vmlinux.lds and drivers/char/hfmodem/tables.h.
These are generated files and should not be in the kernel tarball.

