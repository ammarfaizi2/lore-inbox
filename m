Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSLZBpA>; Wed, 25 Dec 2002 20:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbSLZBpA>; Wed, 25 Dec 2002 20:45:00 -0500
Received: from mail.econolodgetulsa.com ([198.78.66.163]:60941 "EHLO
	mail.econolodgetulsa.com") by vger.kernel.org with ESMTP
	id <S261732AbSLZBo7>; Wed, 25 Dec 2002 20:44:59 -0500
Date: Wed, 25 Dec 2002 17:53:15 -0800 (PST)
From: Josh Brooks <user@mail.econolodgetulsa.com>
To: linux-kernel@vger.kernel.org
Subject: CPU failures ... or something else ?
Message-ID: <20021225175232.O6873-100000@mail.econolodgetulsa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have a dual p3 866 running 2.4 kernel that is crashing once every few
days leaving this on the console:


Message from syslogd@localhost at Tue Dec 24 11:30:31 2002 ...
localhost kernel: CPU 1: Machine Check Exception: 0000000000000004

Message from syslogd@localhost at Tue Dec 24 11:30:32 2002 ...
localhost kernel: Bank 4: b200000000040151

Message from syslogd@localhost at Tue Dec 24 11:30:32 2002 ...
localhost kernel: Kernel panic: CPU context corrupt



Word on the street is that this indicates hardware failure of some kind
(cpu, bus, or memory).  My main question is, is that very surely the
culprit, or is it also possible that all of the hardware is perfect and
that a bug in the kernel code or some outside influence (remote exploit)
is causing this crash ?

Basically, I am ordering all new hardware to swap out, and I just want to
know if there is some remote possibility that my hardware is actually just
fine and this is some kind of software error ?

ALSO, I have not been physically at the console when this has happened,
and have not tried this yet, but whatever that thing is where you press
ctrl-alt-printscreen and get to enter those post-crash commands - do you
think that would work in this situation, or does the above error hard lock
the system so you can't do those emergency measures ?

thanks!


