Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282815AbRLXWVj>; Mon, 24 Dec 2001 17:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282823AbRLXWV3>; Mon, 24 Dec 2001 17:21:29 -0500
Received: from hermes.domdv.de ([193.102.202.1]:14342 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S282815AbRLXWVN>;
	Mon, 24 Dec 2001 17:21:13 -0500
Message-ID: <XFMail.20011224231840.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <5.1.0.14.2.20011224160439.0245ed88@whisper.qrpff.net>
Date: Mon, 24 Dec 2001 23:18:40 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Maybe I have a bad day or something
Cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The good thing about the list is that

if you do have the time to analyze the code and if you can provide a solution
for a problem there are chances that the solution will make it mainstream.

The bad thing about the list is that

if you either don't have the time (as your job may have priority) or if you
just don't understand the code (which can take a lot of time which in turn will
probably contradict that you need to do something for a living) good enough a
non detailed error report or even a error report pointing to a problem without
a fix will go /dev/null quite often.

My wish would be that core delvelopers and maintainers shouldn't forget that the
kernel is a complex thing and that nobody can ever be a crack in all
disciplines. It is just the amount of data a human mind can cope with, taking
into account that most of us can't make a living from lkml/the kernel, leave
alone other open source projects we (might) manage.

Maybe I'm having a bad day, too. To keep things reasonable I would suggest
(again, others have done before) some kind of bug tracking system, at least for
the current stable kernel series.

This would help especially in case of hard to track bugs (thinking of the
initrd problem, I was hit, too) where accumulation of information can lead to
an actual solution of the problem. It would also allow for easier corporate
decision ("is the bug we're hitting closed so can we use the kernel" and
please note that a certain amount of companies is for one reason or the other
not using distros).

Please note that I'm not saying problems aren't solved. I'm not calling people
rude (everybody can have a bad day). It is more or less that if you hit
sufficient noise (lkml traffic) with insufficient information (no time for deep
analysis) your problem reports will probably be lost. And this doesn't help at
all to kernel progress and stability.

I don't know if I'm getting flamed on this one, I don't really care. From now
on I'm back to straightforward Q&A for another year.

PS:  Wouldn't it be an idea to set up lkml-political/lkml-philosophical to
discuss the virtues of KiB and MiB over KB and MB? And if not, isn't it
possible to set up lkml-technical?


