Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130074AbQKNSWH>; Tue, 14 Nov 2000 13:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130191AbQKNSVr>; Tue, 14 Nov 2000 13:21:47 -0500
Received: from warp9.koschikode.com ([212.84.196.82]:26632 "HELO
	warp9.koschikode.com") by vger.kernel.org with SMTP
	id <S130074AbQKNSVa>; Tue, 14 Nov 2000 13:21:30 -0500
Message-ID: <3A117B98.F6F5A5E6@koschikode.com>
Date: Tue, 14 Nov 2000 18:51:20 +0100
From: Juri Haberland <juri@koschikode.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Hard lockup using emu10k1-based sound card
In-Reply-To: <Pine.LNX.4.30.0011131751160.21258-100000@matrix.the-republic.org> <Pine.LNX.4.21.0011141222120.18636-100000@grad.physics.sunysb.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Sousa wrote:
> 
> On Mon, 13 Nov 2000, Willis L. Sarka wrote:
> 
> > I get a hard lockup when trying to play a mp3 with XMMS;
> > Sound Blaster Live card.  The first second loops, and I lose all
> > connectivity to the machine; I can't ping it, can't to a an Alt-Sysq,
> > nothing.
> 
> Is this when you try to play something for the first time or
> it just happens sometimes?
> 
> > Details:
> >
> > running RedHat 7.0
> > using kernel 2.4.0-test11pre4
> > emu10k1 compiled as a module
> > system is a Dell Dimension 4100 (815e based, 512mb ram, 3com 3c905c cardA)
> >
> > I'll try to compile in soundcore and emu10k1 into the kernel, foregoing
> > any modules and see if that helps.  I will also revert back to
> > 2.4.0-test10 as well just to test.
> 
> Yes, it would be good to know when the problems started.
> 
> >  If anyone needs further information,
> > let me know.

Well, just as a note:
I'm using the same (software-) setup as above, only difference is that
the emu10k1 driver is compiled into the kernel and I have no problems
with xmms whatsoever.

Juri
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
