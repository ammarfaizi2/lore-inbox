Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263297AbTCSWb1>; Wed, 19 Mar 2003 17:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263298AbTCSWb1>; Wed, 19 Mar 2003 17:31:27 -0500
Received: from smtp-102.noc.nerim.net ([62.4.17.102]:10761 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id <S263297AbTCSWb0>; Wed, 19 Mar 2003 17:31:26 -0500
Date: Wed, 19 Mar 2003 23:42:24 +0100
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Alexander Hoogerhuis <alexh@ihatent.com>, linux-kernel@vger.kernel.org
Subject: Re: Hard freeze with 2.5.65-mm1
Message-Id: <20030319234224.1da18196.philippe.gramoulle@mmania.com>
In-Reply-To: <20030319121909.74f957af.akpm@digeo.com>
References: <20030319104927.77b9ccf9.philippe.gramoulle@mmania.com>
	<8765qfacaz.fsf@lapper.ihatent.com>
	<20030319182442.4a9fa86c.philippe.gramoulle@mmania.com>
	<877kav5ikv.fsf@lapper.ihatent.com>
	<20030319121909.74f957af.akpm@digeo.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.11claws24 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Just for info, here are my gcc and ld versions:

$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/3.2.3/specs
Configured with: ../src/configure -v --enable-languages=c,c++,java,f77,proto,pascal,objc,ada --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-gxx-include-dir=/usr/include/c++/3.2 --enable-shared --with-system-zlib --enable-nls --without-included-gettext --enable-__cxa_atexit --enable-clocale=gnu --enable-java-gc=boehm --enable-objc-gc i386-linux
Thread model: posix
gcc version 3.2.3 20030309 (Debian prerelease)
$ ld -v
GNU ld version 2.13.90.0.18 20030121 Debian GNU/Linux

Thanks,

Philippe

On Wed, 19 Mar 2003 12:19:09 -0800
Andrew Morton <akpm@digeo.com> wrote:

  | With what compiler are you building your kernels?
