Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132791AbRBEEvx>; Sun, 4 Feb 2001 23:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132814AbRBEEvn>; Sun, 4 Feb 2001 23:51:43 -0500
Received: from rmx195-mta.mail.com ([165.251.48.42]:35039 "EHLO
	rmx195-mta.mail.com") by vger.kernel.org with ESMTP
	id <S132813AbRBEEv0>; Sun, 4 Feb 2001 23:51:26 -0500
Message-ID: <382569872.981348677202.JavaMail.root@web340-wra.mail.com>
Date: Sun, 4 Feb 2001 23:51:12 -0500 (EST)
From: Frank Davis <fdavis112@juno.com>
To: Rusty Russell <rusty@linuxcare.com.au>
Subject: Re: [PATCH] Hot swap CPU support for 2.4.1
CC: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 151.201.242.90
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   Which archs still need to implement it? I briefly looked over the patch and noticed that it had i386, ppc, mips64, and s390 already there.
Regards,
Frank

>Hi all,
>
>I did the infrastructure, Anton did the bugfinding and PPC >support,
>aka. the hard stuff.  Other architectures need to implement
>__cpu_disable, __cpu_die and __cpu_up for them to work.  >Volunteers
>appreciated.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
