Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTERMqx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 08:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTERMqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 08:46:52 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:9606 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id S262037AbTERMqv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 08:46:51 -0400
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>,
       "" <linux-kernel@vger.kernel.org>, "" <linux-mm@kvack.org>
Subject: Re: [OOPS] 2.5.69-mm6
References: <20030516015407.2768b570.akpm@digeo.com>
	<87fznfku8z.fsf@lapper.ihatent.com>
	<20030516180848.GW8978@holomorphy.com>
	<20030516185638.GA19669@suse.de>
	<20030516191711.GX8978@holomorphy.com>
	<Pine.LNX.4.50.0305162322360.2023-100000@montezuma.mastecende.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 18 May 2003 14:59:59 +0200
In-Reply-To: <Pine.LNX.4.50.0305162322360.2023-100000@montezuma.mastecende.com>
Message-ID: <87smrccsvk.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Zwane Mwaikambo <zwane@linuxpower.ca> writes:

> On Fri, 16 May 2003, William Lee Irwin III wrote:
> 
> > Yes, if he could try that too it would help. I got a private reply
> > saying he'd be out of the picture for over 24 hours. I'm looking for
> > someone with a radeon to fill in the gap until then.
> 
> Could you alco specify your GCC version? Your disassembly looks rather 
> odd.
> 

Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/3.2.2/specs
Configured with:
/var/tmp/portage/gcc-3.2.2-r2/work/gcc-3.2.2/configure --prefix=/usr
- --bindir=/usr/i686-pc-linux-gnu/gcc-bin/3.2
- --includedir=/usr/lib/gcc-lib/i686-pc-linux-gnu/3.2.2/include
- --datadir=/usr/share/gcc-data/i686-pc-linux-gnu/3.2
- --mandir=/usr/share/gcc-data/i686-pc-linux-gnu/3.2/man
- --infodir=/usr/share/gcc-data/i686-pc-linux-gnu/3.2/info
- --enable-shared --host=i686-pc-linux-gnu --target=i686-pc-linux-gnu
- --with-system-zlib --enable-languages=c,c++,ada,f77,objc,java
- --enable-threads=posix --enable-long-long --disable-checking
- --enable-cstdio=stdio --enable-clocale=generic --enable-__cxa_atexit
- --enable-version-specific-runtime-libs
- --with-gxx-include-dir=/usr/lib/gcc-lib/i686-pc-linux-gnu/3.2.2/include/g++-v3
- --with-local-prefix=/usr/local --enable-shared --enable-nls
- --without-included-gettext
Thread model: posix gcc version 3.2.2 20030322 (Gentoo Linux 1.4 3.2.2-r2)
GNU ld version 2.14.90.0.2 20030515

Basically gentoo 1.4 "unstable".

mvh,
A
- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+x4PMCQ1pa+gRoggRAjf8AJ9TkVB4Xn70i4696zv2F1VGv6GVawCgwO37
s3Ry8omGNwLQdDD5CT9XiXI=
=B4gm
-----END PGP SIGNATURE-----
