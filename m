Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263667AbTCVScd>; Sat, 22 Mar 2003 13:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263688AbTCVScd>; Sat, 22 Mar 2003 13:32:33 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:15541 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S263667AbTCVScc>; Sat, 22 Mar 2003 13:32:32 -0500
Date: Sat, 22 Mar 2003 19:43:36 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: 2.5.65 interactivity
Message-ID: <Pine.LNX.4.51.0303221929350.28558@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am experiencing dramatic interactivity degradation when
apt-get upgrade is setting up the packages under X, with X running with
nice 0 (it previously had -10)

x-terminal-emualtor windows stop getting refreshed, xmms stops playing,
and after a few seconds everything stops responding and gets going after
another few seconds.

under 2.4, with loads like that (it is not much) interactivity was fine.
2.4, 2.4aa, 2.4-preempt, 2.4-ck, all of them did not result in this
behaviour.

Also sometimes these effects seem to be not related with load, i see no
disc activity, no applications, and still the system hickups.

It happens with 2.5.65, and all -mm[123] patches. (Although i belive mm3
to be a bit more responsive than the rest). I have no history of using
anything prior to 2.5.65.

How can i provide usefull information with what i am experiencing?

What /proc knobs would you recommend to experiment with ?

Regards,
Maciej Soltysiak

