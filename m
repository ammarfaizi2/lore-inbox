Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130259AbQJ1Dfq>; Fri, 27 Oct 2000 23:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130755AbQJ1Dfg>; Fri, 27 Oct 2000 23:35:36 -0400
Received: from smtppop3pub.gte.net ([206.46.170.22]:45358 "EHLO
	smtppop3pub.verizon.net") by vger.kernel.org with ESMTP
	id <S130259AbQJ1DfU>; Fri, 27 Oct 2000 23:35:20 -0400
Message-ID: <39FA4968.62588272@gte.net>
Date: Fri, 27 Oct 2000 23:35:04 -0400
From: "Stephen E. Clark" <sclark46@gte.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lk <linux-kernel@vger.kernel.org>
Subject: RTNL assert
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I configure in Tunneling I get the following error message. Is this
normal? This with 2.4test9pre5

GRE over IPv4 tunneling driver
RTNL: assertion failed at devinet.c(775):inetdev_event
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
