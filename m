Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131221AbRC0LoC>; Tue, 27 Mar 2001 06:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131232AbRC0Lnw>; Tue, 27 Mar 2001 06:43:52 -0500
Received: from atacama.four-d.de ([129.247.190.4]:41223 "EHLO four-d.de")
	by vger.kernel.org with ESMTP id <S131221AbRC0Lnq>;
	Tue, 27 Mar 2001 06:43:46 -0500
Date: Tue, 27 Mar 2001 13:42:39 +0200 (Westeuropäische Sommerzeit)
From: Thomas Pfaff <tpfaff@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.2: System clock slows down under load
Message-ID: <Pine.WNT.4.33.0103271315310.252-101000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1650707-26384-985693359=:252"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1650707-26384-985693359=:252
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi all,

i decided to make a test for the 2.4 kernel on my old hardware (Gigabyte
EISA/VLB with an AMD 486 DX4 133). The kernel boots fine but there is one
strange thing: The system clock slows down under load, after a make
dep in the linux src directory it is about 2 minutes behind. This appears
both in 2.4.1 and in 2.4.2 (I have not tried 2.4.0 yet).

I have attached a gzipped dmesg.

Any ideas ?

Thomas

Please CC my address as i am not a list member.

--1650707-26384-985693359=:252
Content-Type: APPLICATION/octet-stream; name="dmesg.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.33.0103271342390.252@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="dmesg.gz"

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
t6SuTlHYcFpIq/8Cn2Kq5VIVAAA=
--1650707-26384-985693359=:252--
