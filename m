Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbRB0Mw6>; Tue, 27 Feb 2001 07:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129199AbRB0Mwt>; Tue, 27 Feb 2001 07:52:49 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:51214 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129136AbRB0Mwh>; Tue, 27 Feb 2001 07:52:37 -0500
From: mshiju@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA256A00.0046A52B.00@d73mta05.au.ibm.com>
Date: Tue, 27 Feb 2001 18:10:55 +0530
Subject: 2.4.1 compilation error
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
     When I compiled 2.4.1 kernel  on a 2.2.14-5.0 installation (redhat
6.2) ,the following error occurred . But errno.h is there in
/usr/src/linux2.4.1/include/linux/   directory. Have anyone experienced
this problem.

gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
scripts/split-include
scripts/split-include.c
In file included from /usr/include/errno.h:36,
                 from scripts/split-include.c:26:
/usr/include/bits/errno.h:25: linux/errno.h: No such file or directory
make: *** [scripts/split-include] Error 1


Thanks & Regards
Shiju


