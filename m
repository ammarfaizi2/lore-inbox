Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVBUDdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVBUDdA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 22:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVBUDdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 22:33:00 -0500
Received: from fire.osdl.org ([65.172.181.4]:63697 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261745AbVBUDc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 22:32:58 -0500
Message-ID: <421953F0.1090609@osdl.org>
Date: Sun, 20 Feb 2005 19:22:24 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anil Kumar <anilsr@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: driver compile Parse error with gcc-3.4.3
References: <d3a6bba0050220182542696933@mail.gmail.com>
In-Reply-To: <d3a6bba0050220182542696933@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anil Kumar wrote:
> Hi,
> 
> I am new to linux. I am trying to build one of my drivers for
> 2.6.9-5.EL, RHEL 4, I am getting compile parse errors as follows:
> error: parse error before '(' token

Complete gcc output plus driver source file would help a lot.

> #gcc -v
> Configured with: ./configure --prefix=/usr/adaptec/build/gcc343-32bit
> --enable-threads=posix --disable-checking --target=i386-redhat-linux
> --host=i686-redhat-linux-gnu
> --with-libs=/usr/adaptec/build/gcc343-32bit/lib
> --with-headers=/usr/adaptec/build/gcc343-32bit/include
> --enable-languages=c --disable-libunwind-exceptions --with-system-zlib
> --enable-__cxa_atexit --enable-java-awt=gtk --enable-shared
> --mandir=/usr/adaptec/build/gcc343-32bit/man
> --infodir=/usr/adaptec/build/gcc343-32bit/info
> Thread model: posix
> gcc version 3.4.3

-- 
~Randy
