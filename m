Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289312AbSAVONW>; Tue, 22 Jan 2002 09:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289314AbSAVONC>; Tue, 22 Jan 2002 09:13:02 -0500
Received: from purveyor7.dresdnerbank.de ([193.194.7.53]:62224 "EHLO
	purveyor7.Dresdnerbank.de") by vger.kernel.org with ESMTP
	id <S289312AbSAVONA>; Tue, 22 Jan 2002 09:13:00 -0500
Message-Id: <B575BF98FA79D4119BD20008C7A4516502E1C488@ffz00za9.wwz1me.mail.dresdner.net>
From: "Halpaap, Mark (CETA)" <Mark.MH.Halpaap@Dresdner-Bank.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Athlon PSE/AGP Bug
Date: Tue, 22 Jan 2002 15:12:48 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after applying mem=nopentium as a boot parameter
I've been able to play tuxracer _for the first time_.

Prior to this any OpenGL application deepfroze
the system after 10-20 secs.

Tried some other Loki-Demos, they run just fine
now.

I do _not_ have an NVidia card, it's a Matrox G450.

I wasn't able to use OpenGL on both Athlon-systems
I used (was Athlon 600 w/ G400, is a Thunderbird 1333 
w/ G450 now), been trying it ever since XFree86 4.0 and
with (almost) any kernel that was released since then
(It's 2.4.16-pre1 right now).

So whatever the deeper reason, there _is_ something
fishy that this workaround seems to fix and it seems
not to be tied to NVidia drivers.

Mark.
