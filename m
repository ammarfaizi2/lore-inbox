Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130983AbRABRt6>; Tue, 2 Jan 2001 12:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131134AbRABRts>; Tue, 2 Jan 2001 12:49:48 -0500
Received: from p3E9EEB2B.dip.t-dialin.net ([62.158.235.43]:49539 "EHLO
	gate2.private.net") by vger.kernel.org with ESMTP
	id <S131018AbRABRti>; Tue, 2 Jan 2001 12:49:38 -0500
Message-Id: <200101021719.f02HJVn02506@gate2.private.net>
From: "Otto Meier" <gf435@gmx.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 02 Jan 2001 18:19:41 +0100
Reply-To: "otto meier" <gf435@gmx.net>
X-Mailer: PMMail 2000 Professional (2.10.2010) For Windows 98 (4.10.2222)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: kernel freeze on 2.4.0.prerelease (smp,raid5)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On all kernels newer than 2.4.0t13p3 I have the following problem.

shorly after boot (some seconds) the system freeze. I can only swith consoles
but i am not able to login. Over the net I get onyl responses to
pings nothing else.

Up to kernel 2.4.0.t13p3 everythings works fine.

Sorry for this simple description, but I am not able to get more clear infos.
No oops, nothing in the logs after reboot with 240t13p3.

Perhaps someone has an idea where to dig?

ps: Here is my short system description:

Dual Celeron (SMP)
Raid5 (3 drives actuall 2 drives degra. mode)







-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
