Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268373AbTAMW1e>; Mon, 13 Jan 2003 17:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268374AbTAMW1e>; Mon, 13 Jan 2003 17:27:34 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:1552 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S268373AbTAMW1d>; Mon, 13 Jan 2003 17:27:33 -0500
Message-ID: <3E23297A.46A57515@linux-m68k.org>
Date: Mon, 13 Jan 2003 22:02:50 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: make xconfig broken in bk current
References: <200301121512.59840.tomlins@cam.org> <20030112203150.GA53199@compsoc.man.ac.uk> <3E2200C6.665A12CA@linux-m68k.org> <20030113012032.GA73639@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

John Levon wrote:

> > We can discuss this during 2.7, until then I prefer to keep it close to
> > the kernel, as the config system still has to mature a bit more.
> 
> OK, so you're fine with the moving to a different package when the
> config library reaches a stable API ? Fair enough.

Yes, my main requirement is that the separate package is working fine in
a few distributions.

> You don't seem to set MOC correctly if you guess a Qt dir. It doesn't
> cater for binaries called moc2 or libraries called qt3 or qt2[1]

I haven't seen this yet and I would expect (sym)links to the default
version.

bye, Roman


