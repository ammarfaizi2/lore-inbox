Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310378AbSCBNV2>; Sat, 2 Mar 2002 08:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310376AbSCBNVS>; Sat, 2 Mar 2002 08:21:18 -0500
Received: from velli.mail.jippii.net ([195.197.172.114]:5062 "HELO
	velli.mail.jippii.net") by vger.kernel.org with SMTP
	id <S310378AbSCBNVH> convert rfc822-to-8bit; Sat, 2 Mar 2002 08:21:07 -0500
Message-Id: <5.0.2.1.0.20020302151453.00b2e930@pop.mbnet.fi>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sat, 02 Mar 2002 15:20:52 +0200
To: linux-kernel@vger.kernel.org
From: Toni =?iso-8859-1?Q?Syv=E4nen?= <syvanen@mbnet.fi>
Subject: FrameBuffer development
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm working on small patch for fb on linux.
But anyways i got one really stupid question. To who should i
send the patch? (hides from the angry people and gives everyone
a free softie pinguin, please put our agressive behavior on the toy, thx)

My idea is to make it more "fail safe" because i have runned into problems
when using fb. I have to reboot, and reboot..... to find the right settings.
Sollution is that kernel waits and asks if the new resolution works. and if
you don't answer yes in 10 seconds, it gets back to the old settings.

__
Toni Syvänen aka "ToM"
a Stubborn Finn

