Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274406AbRITKaY>; Thu, 20 Sep 2001 06:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274410AbRITKaO>; Thu, 20 Sep 2001 06:30:14 -0400
Received: from cy60022-a.vnnys1.ca.home.com ([24.21.33.25]:3332 "EHLO
	cy60022-a.vnnys1.ca.home.com") by vger.kernel.org with ESMTP
	id <S274406AbRITK34>; Thu, 20 Sep 2001 06:29:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Android <android@abac.com>
Reply-To: android@abac.com
Organization: Androids Unlimited
To: linux-kernel@vger.kernel.org
Subject: Error compiling 2.4.9 as bzImage
Date: Thu, 20 Sep 2001 03:34:18 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01092003271500.00371@cy60022-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following errors occured while trying to compile kernel 2.4.9:

unistr.c: In function `ntfs_collate_names':
unistr.c:99: warning: implicit declaration of function `min'
unistr.c:99: parse error before `unsigned'
unistr.c:99: parse error before `)'
unistr.c:97: warning: `c1' might be used uninitialized in this function
unistr.c: At top level:
unistr.c:118: parse error before `if'
unistr.c:123: warning: type defaults to `int' in declaration of `c1'
unistr.c:123: `name1' undeclared here (not in a function)
unistr.c:123: warning: data definition has no type or storage class
unistr.c:124: parse error before `if'
make[3]: *** [unistr.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.9/fs/ntfs'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.9/fs/ntfs'
make[1]: *** [_subdir_ntfs] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.9/fs'
make: *** [_dir_fs] Error 2

kmail crashes when I try to attach the configuration file so ....




