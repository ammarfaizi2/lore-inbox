Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285327AbSACKqQ>; Thu, 3 Jan 2002 05:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285338AbSACKqJ>; Thu, 3 Jan 2002 05:46:09 -0500
Received: from pulsar.kss-loka.si ([193.2.59.99]:1809 "HELO pulsar.kss-loka.si")
	by vger.kernel.org with SMTP id <S285327AbSACKpw>;
	Thu, 3 Jan 2002 05:45:52 -0500
Date: Thu, 3 Jan 2002 11:46:04 +0100 (CET)
From: Uros Bizjak <uros@kss-loka.si>
To: davej@suse.de
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-dj10, 486 string copies
Message-ID: <Pine.LNX.4.05.10201031141560.6476-100000@pulsar.kss-loka.si>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

  There is still patch to string-486.h at http://www.dce.bg/~petkan/
waiting for inclusion in 2.4 kernel.

  This patch was written by Petko Manolov (petkan@dce.bg) and can be found
at http://www.dce.bg/~petkan/linux/string-486.diff

  Intro to patch says:

  Patch to .../linux-2.4.0-test7/include/asm-i386/string-486.h. memset and
memcpy routines was completely rewritten in order to get higher
performance. The aim is to go in final 2.4 kernels so please test. 

	Uros.

