Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130245AbQKINl3>; Thu, 9 Nov 2000 08:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130738AbQKINlM>; Thu, 9 Nov 2000 08:41:12 -0500
Received: from iisc.ernet.in ([144.16.64.3]:9997 "EHLO iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S130245AbQKINky>;
	Thu, 9 Nov 2000 08:40:54 -0500
From: anand@eis.iisc.ernet.in (SVR Anand)
Message-Id: <200011091340.TAA05912@eis.iisc.ernet.in>
Subject: Buffer copying latency
To: linux-kernel@vger.kernel.org
Date: Thu, 9 Nov 2000 19:10:42 +0530 (GMT+05:30)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry if it is a naive question.

I would like to know if there are any measurements made on a typical Pentium
machine with respect to the latency for buffer copying from the user to kernel 
and vice versa. While there are many papers, and arguments that attempt to
ban buffering copying of any sort, especially the ones that cross protection
boubdaries, I am searching in vain to obtain the numbers that highlight the 
overheads. Can you help me getting this information ?


It also causes a bit of worry that the recent trends seem to violate the nice
conventional Unix philosophy in the name of performance,... just because the
current RAM access speeds are not upto the mark. What would happen if some
technology breakthrough occurs and the RAM access times fall drastically ?

Regards
Anand
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
