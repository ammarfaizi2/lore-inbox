Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVBUC0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVBUC0F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 21:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVBUC0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 21:26:05 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:58502 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261526AbVBUCZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 21:25:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=sn07RP2id8r/IcU1Vq1A/AkZ2G3Z8VJgR0SkDcahi50fay3kNnTqKe1ZdUYvHC4lqgjeszdMBXeLXkO5egXLhafrm4X1NsqJ7Oo/V8Ask6EF0n1sptgIDfWEYjOLYJc094MC/fmdKZ3svk1cN52s4RtPOWNgSlfWfDrUHYVMPvM=
Message-ID: <d3a6bba0050220182542696933@mail.gmail.com>
Date: Sun, 20 Feb 2005 18:25:58 -0800
From: Anil Kumar <anilsr@gmail.com>
Reply-To: Anil Kumar <anilsr@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: driver compile Parse error with gcc-3.4.3
Cc: anilsr@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am new to linux. I am trying to build one of my drivers for
2.6.9-5.EL, RHEL 4, I am getting compile parse errors as follows:
error: parse error before '(' token

#gcc -v
Configured with: ./configure --prefix=/usr/adaptec/build/gcc343-32bit
--enable-threads=posix --disable-checking --target=i386-redhat-linux
--host=i686-redhat-linux-gnu
--with-libs=/usr/adaptec/build/gcc343-32bit/lib
--with-headers=/usr/adaptec/build/gcc343-32bit/include
--enable-languages=c --disable-libunwind-exceptions --with-system-zlib
--enable-__cxa_atexit --enable-java-awt=gtk --enable-shared
--mandir=/usr/adaptec/build/gcc343-32bit/man
--infodir=/usr/adaptec/build/gcc343-32bit/info
Thread model: posix
gcc version 3.4.3

regards,
 Anil
