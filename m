Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbUCDATD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 19:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbUCDAQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 19:16:28 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:17553 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261227AbUCDAPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 19:15:34 -0500
Subject: [RFC] vsyscall-gtod_test_B3.tar.gz
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Andi Kleen <ak@suse.de>,
       Ulrich Drepper <drepper@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>, Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <1078359081.10076.191.camel@cog.beaverton.ibm.com>
References: <1078359081.10076.191.camel@cog.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-8OsIA4XqLJiiRGkvogqd"
Message-Id: <1078359307.10076.199.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 03 Mar 2004 16:15:07 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8OsIA4XqLJiiRGkvogqd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

All,
	This tarball shows an example on how to use the LD_PRELOAD method of
calling vsyscall-gtod. This method is used in the absense of
vsyscall-gtod_B3-part3 patch, or on systems without a sysenter enabled
glibc. The example provides a micro-benchmark that compares the
performance of gettimeofday() when calling it normally, or through the
LD_PRELOAD method.

thanks
-john



--=-8OsIA4XqLJiiRGkvogqd
Content-Disposition: attachment; filename=vsyscall-gtod_test_B3.tar.gz
Content-Type: application/x-compressed-tar; name=vsyscall-gtod_test_B3.tar.gz
Content-Transfer-Encoding: base64

H4sICJpzRkAAA3ZzeXNjYWxsLWd0b2RfdGVzdF9CMy50YXIA7Vfrb9o6FO9X/FccdeoEFEJS8pDG
Omlru6kSpVO73rtJk1CaGOLNxCh2uOuu9r/vOOFd1H5BdA//PmB8nraPj8/JRN7JKOS8OVQi7isq
Vf9Nu7W3Vdi2aweeh6PjeHaAI/5z3WKcYs+x7SPHDRxf8x3XD7w98La7jM3IpQozgL0vUuVcfX9A
jmZyFwvaLSYb4z+jWtE2fNgYXL+I9+b4e743j7/nt1HeD2yMv70N54/hL4//M5ZGPI8pvJQqZsJK
XpEVEme3mkZadbhORM5jeHv+sf/P9afrk9fdbv/dh8tTiJIwHVJgKQzYt1E4tpIGgTqohEmYhBkL
bzmF/xjnkFIagxJwSyGMv+DRl1OVUK0wCXlOYZyxVNNDBbdCKFBsRC1kt8izmA5YSmHFe/+s9+Hq
E9jfBogIb9NNl5CJYDFU6/oa16pSZXlU2kEP9QasEWpwDFWtUa9tsNyZWhtSpRXEIA7v1k2CmsA9
s6C+18j/pDJbhpo0kNIhPwh56qAvYXP+X4Rf8ag53Y6Px/K/7WDOY4FoB0eua7s6/9tu2+T/LoCh
f0EqwyiC5uD9+Qk0s/guDUcM50No4u+/KAGLejCVlUmYYY4imzelQAXamMtIYTnQFLBCsGwkzikC
mhyt8JiX9vTla+rLZ0Vacz4lJOI0THGF2Qjq1hLnvvVfKat+H2zO/6V4bMHHI/nvOG2kBb7T9j0n
cIr8D3zf5P8u8HD9v5OtovzqDmBWfXs3F/2rm941OGX45oyL85OryzmVYBWHUcjSalEFV4sj6ENX
umSKcUPX/Q6paHmGY55KNkzxceEiHZY/MeUqRNaAC+wKxjSLaKpwvpBQozHOV2r086mP3k23W9PK
IquyY7sDDF7ON4Gzw8Maqayp4ooWiutW9ZJnPL0xMbbUpC8pPl3H5cam886Cm6+z85Jf7Ez3H/d3
XVuyXC/PFtdZOXxQtjRLKtMz0paLQ6sVjlrV2b4PHb36otUaVPeXdwhVOOA8zyW04IBl6At0g3Qw
yOXndL+h11DYaszPsDGLCJoEREZVnqVg61bnqa+3wSPY/P5j2C2ZbMuHfv8f+v53gqNZ/+fZnv7+
9/Gb0Lz/uwCNEgH7PZGN8FVefgf2ibVoA0gpNrss0D3tv786616+Pl3TWTCOrdb9BnDZ5FPv3MDA
wMDAwMDAwMDAwMDAwMDAwMDgz8ZPJLGuSwAoAAA=

--=-8OsIA4XqLJiiRGkvogqd--

