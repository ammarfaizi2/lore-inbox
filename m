Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286411AbRL0SLs>; Thu, 27 Dec 2001 13:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286425AbRL0SLi>; Thu, 27 Dec 2001 13:11:38 -0500
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:28940 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S286411AbRL0SLd>;
	Thu, 27 Dec 2001 13:11:33 -0500
Message-ID: <3C2B62E8.2080105@si.rr.com>
Date: Thu, 27 Dec 2001 13:05:28 -0500
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.2-pre2: drivers/md/lvm.c compile error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
     I didn't see this on lkml yet..If already posted, sorry in advance.

lvm.c: In function 'lvm_user_bmap':
lvm.c:1046: request for member 'bv_len' in something not a structure or 
union
make[2]: *** [lvm.o] Error 1
make[2]: Leaving directory '/usr/src/linux/drivers/md'

Regards,
Frank

