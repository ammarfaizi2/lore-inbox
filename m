Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277509AbRK0Lx1>; Tue, 27 Nov 2001 06:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277435AbRK0LxR>; Tue, 27 Nov 2001 06:53:17 -0500
Received: from portal.east.saic.com ([198.151.13.15]:40150 "HELO
	portal.east.saic.com") by vger.kernel.org with SMTP
	id <S277514AbRK0LxG>; Tue, 27 Nov 2001 06:53:06 -0500
Subject: latest 2.4 kernels freeze after uncompressing linux
From: Eamonn Hamilton <eamonn.hamilton@saic.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 27 Nov 2001 11:56:37 +0000
Message-Id: <1006862198.5581.0.camel@hecate>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Guys.

I'm setting up a machine for a friend, and I've got a weird problem.

On a motherboard ( and old M571 I think )  with a Cyrix 686L processor I
can't boot any of the recent series of kernels. When booting, I get the
loading Linux and tye uncpressing stage, but it then locks solid. It
looks like the bzimage problem that was around a good long while ago,
however I CAN boot 2.2.15 which is also a bzImage. I've tried compiling
the kernels as i386, as well as 586, and I've also tried the debian
dstrbution kernels ( it's debian unstable, by the way ).

Anybody got any ideas?

Chers,
Eamonn

