Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267434AbTBUNuu>; Fri, 21 Feb 2003 08:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267437AbTBUNuu>; Fri, 21 Feb 2003 08:50:50 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:1672
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267434AbTBUNut>; Fri, 21 Feb 2003 08:50:49 -0500
Subject: Re: No Subject
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: News Admin <news@nimloth.ics.muni.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200302211343.h1LDhTM13523@nimloth.ics.muni.cz>
References: <200302211343.h1LDhTM13523@nimloth.ics.muni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045839704.5275.41.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 21 Feb 2003 15:01:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-21 at 13:43, News Admin wrote:
> $ gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-linux/3.2.3/specs
> Configured with: ../src/configure -v
> --enable-languages=c,c++,java,f77,proto,pascal,objc,ada --prefix=/usr
> --mandir=/usr/share/man --infodir=/usr/share/info
> --with-gxx-include-dir=/usr/include/c++/3.2 --enable-shared
> --with-system-zlib --enable-nls --without-included-gettext
> --enable-__cxa_atexit --enable-clocale=gnu --enable-java-gc=boehm
> --enable-objc-gc i386-linux
> Thread model: posix
> gcc version 3.2.3 20030210 (Debian prerelease)

How about using a released gcc compiler not a snapshot. gcc 3.2.1
and 3.2.2 appear to work fine. According to the FSF there is no
gcc 3.2.3 yet, so it isn't suprising a snapshot would have bugs

