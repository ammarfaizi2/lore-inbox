Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272255AbRHWMys>; Thu, 23 Aug 2001 08:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272253AbRHWMy2>; Thu, 23 Aug 2001 08:54:28 -0400
Received: from web10402.mail.yahoo.com ([216.136.130.94]:7184 "HELO
	web10402.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S272252AbRHWMyR>; Thu, 23 Aug 2001 08:54:17 -0400
Message-ID: <20010823125433.88094.qmail@web10402.mail.yahoo.com>
Date: Thu, 23 Aug 2001 22:54:33 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: (was posted)2.4.9-compilation error, pls help
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry but I lost the email and can not compile it. I
still remember that someone made a patch available to
fix it. pls show me :-))



ux/modversions.h -DNTFS_VERSION=\"1.1.16\"   -c -o
unistr.o unistr.c
unistr.c: In function `ntfs_collate_names':
unistr.c:99: warning: implicit declaration of function
`min'
unistr.c:99: parse error before `unsigned'
unistr.c:99: parse error before `)'
unistr.c:97: warning: `c1' might be used uninitialized
in this function
unistr.c: At top level:
unistr.c:118: parse error before `if'
unistr.c:123: warning: type defaults to `int' in
declaration of `c1'
unistr.c:123: `name1' undeclared here (not in a
function)
unistr.c:123: warning: data definition has no type or
storage class
unistr.c:124: parse error before `if'
make[2]: *** [unistr.o] Error 1
make[2]: Leaving directory `/home/linux/fs/ntfs'
make[1]: *** [_modsubdir_ntfs] Error 2
make[1]: Leaving directory `/home/linux/fs'
make: *** [_mod_fs] Error 2


=====
S.KIEU

_____________________________________________________________________________
http://shopping.yahoo.com.au - Father's Day Shopping
- Find the perfect gift for your Dad for Father's Day
