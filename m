Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVEPRLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVEPRLs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 13:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVEPRLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 13:11:47 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:35510 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S261764AbVEPRLh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 13:11:37 -0400
From: dth@picard.cistron.nl (Danny ter Haar)
Subject: Re: 2.6.12-rc4-mm2
Date: Mon, 16 May 2005 17:11:37 +0000 (UTC)
Organization: Cistron
Message-ID: <d6ak89$vr8$1@news.cistron.nl>
References: <20050516021302.13bd285a.akpm@osdl.org> <200505161517.40802.adobriyan@gmail.com> <d6a0oj$akh$1@news.cistron.nl> <200505161615.50884.adobriyan@gmail.com>
X-Trace: ncc1701.cistron.net 1116263497 32616 62.216.30.70 (16 May 2005 17:11:37 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@picard.cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan  <adobriyan@gmail.com> wrote:
>> Alexey Dobriyan  <adobriyan@gmail.com> wrote:
>> >Does this help?
>> Nope, (unfortunatly)
>Please, try this.

[Patch #2 applied]

Still not succesful..

Error is at
http://newsgate.newsserver.nl/kernel/2.6.12-rc4-mm2-patch%232-error-out.txt

btw:
newsgate:/usr/src/linux-2.6.12-rc4-mm2# gcc -v
Reading specs from /usr/lib/gcc-lib/x86_64-linux/3.3.6/specs
Configured with: ../src/configure -v
--enable-languages=c,c++,java,f77,pascal,objc,ada,treelang
--prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info
--with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared
--enable-__cxa_atexit --with-system-zlib --enable-nls
--without-included-gettext --enable-clocale=gnu --enable-debug
--enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc
--disable-multilib x86_64-linux
Thread model: posix
gcc version 3.3.6 (Debian 1:3.3.6-4)

newsgate:/var/www/kernel# ls -lrt
-rw-r--r--  1 root root  3638 May 16 13:36 2.6.12-rc4-mm2-error-out.txt
-rw-r--r--  1 root root  5389 May 16 19:07 2.6.12-rc4-mm2-patch#2-error-out.txt

Thanks for your efforts to help me!


Danny
-- 
The foundation of evil is made up of lies and marketing - UF2004

