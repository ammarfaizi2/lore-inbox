Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273421AbRINQWj>; Fri, 14 Sep 2001 12:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273422AbRINQW2>; Fri, 14 Sep 2001 12:22:28 -0400
Received: from pD9508A29.dip.t-dialin.net ([217.80.138.41]:28978 "EHLO
	bennew01.localdomain") by vger.kernel.org with ESMTP
	id <S273421AbRINQWW>; Fri, 14 Sep 2001 12:22:22 -0400
Date: Fri, 14 Sep 2001 18:23:25 +0200
From: Matthias Haase <matthias_haase@bennewitz.com>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: repeatable SMP lockups - kernel 2.4.9
Message-Id: <20010914182325.225a7211.matthias_haase@bennewitz.com>
In-Reply-To: <Pine.LNX.4.21.0109141634490.1830-100000@tux.rsn.bth.se>
In-Reply-To: <20010914143021.0a5c9791.matthias_haase@bennewitz.com>
	<Pine.LNX.4.21.0109141634490.1830-100000@tux.rsn.bth.se>
X-Operating-System: linux smp kernel 2.4* on i686
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Martin,


I hope, this sounds not to stupid:

As an hardware test I have run quake3d_demo with enabled DRI. 
For this, I have compiled the 2.4.9 kernel the older DRM-code in, so I
could use the installed Xfree86 4.03 instead the required 4.1:

No error, no lockup, even though this game produced heavy load on ram and
harddisks.
No lockup too with the small traffic on the NIC,  for instance with the
ADSL-connection (max. 90 kb/s) to our router.
But, as I sayd, repeatable lockups with some higher network-traffic inside
the LAN.


regards

                          Matthias

-- 
Gruesse


Matthias Haase            | Telefon +49-(0)3733-23713
Markt 2                   | Telefax +49-(0)3733-22660
                          |
D-09456 Annaberg-Buchholz | http://www.bennewitz.com

