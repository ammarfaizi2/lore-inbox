Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129752AbQK3KMv>; Thu, 30 Nov 2000 05:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132120AbQK3KMc>; Thu, 30 Nov 2000 05:12:32 -0500
Received: from [195.3.86.158] ([195.3.86.158]:26896 "EHLO smtp1.lix.aon.at")
        by vger.kernel.org with ESMTP id <S129752AbQK3KMY>;
        Thu, 30 Nov 2000 05:12:24 -0500
Message-ID: <90A461C34D90D111BA690020AFF7B3C873C5DE@x2-winnt.axioma.co.at>
From: Franz Reitinger <FranzR@axioma.co.at>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11, 3c509
Date: Thu, 30 Nov 2000 10:44:23 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
        charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
After patching & recompiling the kernel/modules the system cannot find the
3com NIC (3c509). The init_module() tells, that such a card cannot be found.
I played a little bit with several parameters (irq, xcvr), but it didn't
help. The driver refuses simple to reconize the card. 
It goes without saying that former versions did reconize the card.

ThanX
franzReitinger

"What you want is irrelevant. What you have chosen is at hand!" 
---Spock, Star Trek VI
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
