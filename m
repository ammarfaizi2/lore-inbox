Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAPC6e>; Mon, 15 Jan 2001 21:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbRAPC6Z>; Mon, 15 Jan 2001 21:58:25 -0500
Received: from d247.as5200.mesatop.com ([208.164.122.247]:10888 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S129406AbRAPC6T>; Mon, 15 Jan 2001 21:58:19 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
Date: Mon, 15 Jan 2001 20:00:09 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: 2.4.1-pre7 build error.
MIME-Version: 1.0
Message-Id: <01011520000900.01250@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this for 2.4.1-pre7

make[2]: *** No rule to make target `/usr/src/linux/incl', needed by 
`softirq.o'.  Stop.
make[2]: *** Waiting for unfinished jobs....
make[2]: Leaving directory `/usr/src/linux-2.4.1-pre7/kernel'
make[1]: *** [first_rule] Error 2

Waiting for 2.4.1-pre8.  

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
