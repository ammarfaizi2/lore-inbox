Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130207AbQJ1DeH>; Fri, 27 Oct 2000 23:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130259AbQJ1Dd5>; Fri, 27 Oct 2000 23:33:57 -0400
Received: from smtppop2pub.gte.net ([206.46.170.21]:5156 "EHLO
	smtppop2pub.verizon.net") by vger.kernel.org with ESMTP
	id <S130207AbQJ1Ddr>; Fri, 27 Oct 2000 23:33:47 -0400
Message-ID: <39FA490E.1F001373@gte.net>
Date: Fri, 27 Oct 2000 23:33:34 -0400
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
normal?

GRE over IPv4 tunneling driver
RTNL: assertion failed at devinet.c(775):inetdev_event
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
