Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbRBXWbP>; Sat, 24 Feb 2001 17:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129665AbRBXWbB>; Sat, 24 Feb 2001 17:31:01 -0500
Received: from mclean.mail.mindspring.net ([207.69.200.57]:35369 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S129664AbRBXWar>; Sat, 24 Feb 2001 17:30:47 -0500
Message-ID: <003601c09eb1$2e8063e0$1601a8c0@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: <linux-kernel@vger.kernel.org>, "Jeff Lessem" <Jeff.Lessem@Colorado.EDU>
Cc: "Philipp Rumpf" <prumpf@mandrakesoft.com>
In-Reply-To: <200102240941.CAA09708@ibg.colorado.edu> <Pine.LNX.4.10.10102240532030.30331-100000@penguin.transmeta.com> <20010224095447.A28983@mandrakesoft.mandrakesoft.com> <200102241725.KAA19514@ibg.colorado.edu> <20010224115507.B28983@mandrakesoft.mandrakesoft.com>  <200102241836.LAA27025@ibg.colorado.edu>
Subject: Re: PCI oddities on Dell Inspiron 5000e w/ 2.4.x 
Date: Sat, 24 Feb 2001 17:28:56 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In your message of: Sat, 24 Feb 2001 11:55:07 CST, you write:
> >
> >Careful, you're overwriting ACPI data now (and using it as normal RAM).
>
> Hmm, I guess that would be bad.
>
> >Can you try one of a) LILO b) a fixed version of grub c) this patch ?
>
> I tried LILO and the problem did indeed go away when using that.  I
> guess I'll stick with LILO until Linux or grub (whichever is broken)
> is fixed.  There is just something appealing about a proper boot
> console on a PC...

Even though I wasn't much help on this, it's nice to know what was different
on your config that was causing problems while I wasn't seeing any issues.
I sat here for almost an hour last night trying to figure out why your
machines memory map would different than mine (I have 320MB of RAM as well,
so they should have been the same).  The thought that you might be using a
different boot loader never even crossed my mind.  I've always used LILO so
that's why I didn't see any problems.

It's nice to know it wasn't just working for me by accident.

Later,
Tom


