Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266078AbRF2NqJ>; Fri, 29 Jun 2001 09:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbRF2Np7>; Fri, 29 Jun 2001 09:45:59 -0400
Received: from flurry.inode.at ([195.58.161.103]:63186 "EHLO smtp.inode.at")
	by vger.kernel.org with ESMTP id <S265472AbRF2Npu>;
	Fri, 29 Jun 2001 09:45:50 -0400
Message-ID: <013101c100a1$c2bebfa0$f216e5d5@lilly>
From: "darx kies" <darx_kies@gmx.net>
To: "linux kernel" <linux-kernel@vger.kernel.org>
Subject: CLOSE_WAIT Problem
Date: Fri, 29 Jun 2001 15:45:28 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I wrote a simple server application and installed it on a linux machine
in Slovakia, running Mandrake 7.2 (2.2.18).
That machine loses tcp/ip packages, as it uses a Microwave connection.
So my server works all the time, and the tcp/ip connections are set to
TIME_WAIT, but after a couple of hours
my server application won't get any connections anymore and the netstat
shows a lot of CLOSE_WAITs that belong to the server.
I've installed the same server on two SuSE 7.1 (2.2.18) machines in
Austria, and the problem never occured.
So does anyone know how to avoid that CLOSE_WAITs, or at least how to
get rid of  them?
Thanks in advance.

Chriss.
----------
The last good thing written in C was Schubert's Symphony No. 9.



