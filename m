Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266166AbRGDUH0>; Wed, 4 Jul 2001 16:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266163AbRGDUHQ>; Wed, 4 Jul 2001 16:07:16 -0400
Received: from slentms1.vantcom.net ([200.225.160.21]:18192 "EHLO
	slentms1.vantcom.net") by vger.kernel.org with ESMTP
	id <S266171AbRGDUHH>; Wed, 4 Jul 2001 16:07:07 -0400
Message-ID: <734932D6EA60D511A13600508BDE724864D6@slentms1.vantcom.net>
From: Alessandro Motter Ren <Alessandro.Ren@vantcom.net>
To: "'George Bonser'" <george@gator.com>,
        Ronald Bultje <rbultje@ronald.bitfreak.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: >128 MB RAM stability problems (again)
Date: Wed, 4 Jul 2001 17:06:51 -0300 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Which filesystem are you using on this machine?
	[]s.

-----Original Message-----
From: George Bonser [mailto:george@gator.com]
Sent: Wednesday, July 04, 2001 5:06 PM
To: Ronald Bultje; Linux Kernel Mailing List
Subject: RE: >128 MB RAM stability problems (again)


> I'm kind of astounded now, WHY can't linux-2.4.x run on ANY machine in
> my house with more than 128 MB RAM?!? Can someone please point out to me
> that he's actually running kernel-2.4.x on a machine with more than 128
> MB RAM and that he's NOT having severe stability problems?

Running 2.4.6-pre and 2.4.6 proper on several machines. Quite busy and all
have 256 to 512MB of RAM. As I type this, I am in the process of converting
an entire production server farm over to 2.4.6 from 2.2.19 as the 2.4.6-pre
series proved out well on a test machine in that farm.  No stability
problems at all. The only reboots were for patching up the kernel to the
next -pre revision on that test box.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
