Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRAIJNv>; Tue, 9 Jan 2001 04:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131148AbRAIJNl>; Tue, 9 Jan 2001 04:13:41 -0500
Received: from [212.93.138.10] ([212.93.138.10]:2821 "HELO mail.delrom.ro")
	by vger.kernel.org with SMTP id <S129485AbRAIJNa>;
	Tue, 9 Jan 2001 04:13:30 -0500
Date: Tue, 9 Jan 2001 11:12:47 +0200
From: Silviu Marin-Caea <silviu@delrom.ro>
To: linux-kernel@vger.kernel.org
Cc: rlug@lug.ro
Subject: Failure building 2.4 while running 2.4.  Success in building 2.4 while running 2.2.
Message-Id: <20010109111247.397581ea.silviu@delrom.ro>
X-Mailer: Sylpheed version 0.4.9 (GTK+ 1.2.8; Linux 2.2.16-22; i686)
Organization: Delta Romania
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.5.0.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have RedHat7, glibc-2.2-9, gcc-2.96-69.

I can build 2.4.0 while running kernel 2.2.16.

If I try to rebuild 2.4.0 while running the new kernel, I get random
compiler errors.

It happens on two machines.  One of them runs 2.4.0-test12, the other
2.4.0.  Both of them with the updates above mentioned.

I know this is a RedHat issue, but it may be useful to know for some.

-- 
Systems and Network Administrator - Delta Romania
Phone +4093-267961
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
