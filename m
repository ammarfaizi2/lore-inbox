Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263116AbREaRFu>; Thu, 31 May 2001 13:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263117AbREaRFj>; Thu, 31 May 2001 13:05:39 -0400
Received: from [61.75.51.13] ([61.75.51.13]:1028 "EHLO gateway.sora.com")
	by vger.kernel.org with ESMTP id <S263116AbREaRFb>;
	Thu, 31 May 2001 13:05:31 -0400
Message-ID: <3B1676BA.B42CD722@flyduck.com>
Date: Fri, 01 Jun 2001 01:52:10 +0900
From: Lee Ho <i@flyduck.com>
X-Mailer: Mozilla 4.72 [en] (Win98; I)
X-Accept-Language: ko,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: File read
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I wrote some functions for file handling in kernel module. 
Check the source : http://linuxkernel.to/klib/klib/src/fileio.c
(The basic idea is from khttpd)

This is part of my personal klib (kernel library) project. 
You can download the full source : http://klib.sourceforge.net/download/klib.tar.gz

*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
Lee, Ho. Software Engineer, Embedded Linux Dep, LinuxOne 
ICQ : #52017992, Mail : flyduck@linuxone.co.kr, i@flyduck.com
Homepage : http://flyduck.com, http://linuxkernel.to

Anil Kumar Wrote:
>How do i read file within the kernel modules. I hope we can't use the FS
>open... calls within kernel.
