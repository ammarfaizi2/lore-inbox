Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289987AbSAPQA6>; Wed, 16 Jan 2002 11:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289986AbSAPQAt>; Wed, 16 Jan 2002 11:00:49 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:63154 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289985AbSAPQAg>; Wed, 16 Jan 2002 11:00:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Christian Armingeon <linux.johnny@gmx.net>
To: Bill Davidsen <davidsen@tmr.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: KDE hang with 2.4.18-pre3-ac2
Date: Wed, 16 Jan 2002 18:00:31 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.3.96.1020116103205.28369E-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020116103205.28369E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16QsTK-0yvhtAC@fmrl10.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got the same problems with SuSE7.3 and kde2.2.2.
With kernel 2.4.17, the X locks up, when I push the power button, the box tries to shut doen [I can hear a beep], but nothing else happens. After two or three sysrq keys specally sigterm to all processes, the system locks hard [reset cycle needed].
I am trying 2.4.18-pre4 now.

Johnny
Am Mittwoch, 16. Januar 2002 16:37 schrieb Bill Davidsen:
> I got an interesting symptom on the first machine I tried using the new
> -ac2 kernel. The KDE bar wouldn't launch any applications. The rest of the
> system was running just fine, applications running, `sessions' starting
> connections to various machines, mail going along, but KDE just didn't
> start apps, with no errors.
>
> After reboot all was fine, restarting KDE didn't change anything.
>
> I mention this only as something people might shrug off otherwise, but
> this KDE hasn't done that, and it's an old one from Slack7.0. Can't
> replicate otherwise, this is not a bug report proper or not, just
> something to notice. If restarting KDE fixed it I'd say it was a KDE bug,
> but it didn't.
