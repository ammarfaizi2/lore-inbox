Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281638AbRKZMHN>; Mon, 26 Nov 2001 07:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281643AbRKZMHE>; Mon, 26 Nov 2001 07:07:04 -0500
Received: from mailhost.cendio.se ([193.180.23.130]:7414 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id <S281638AbRKZMGw>;
	Mon, 26 Nov 2001 07:06:52 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16-pre1
In-Reply-To: <20011124214114.E241@localhost> <46FF80FA-E151-11D5-A24C-00306569F1C6@haque.net>
From: Martin Persson <martin@cendio.se>
Date: 26 Nov 2001 13:06:50 +0100
In-Reply-To: mhaque@haque.net's message of "Sat, 24 Nov 2001 22:05:27 -0500"
Message-ID: <vwbshp3fdx.fsf@akrulino.lkpg.cendio.se>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 24 Nov 2001 22:05:27 -0500, mhaque@haque.net ("Mohammad A. Haque") said:

    Mohammad> On Saturday, November 24, 2001, at 09:41 , Patrick
    Mohammad> McFarland wrote:
    >> Okay, so it was 14 that had the file loopback bug, and 12 that
    >> had the ieee bug.Those bugs shouldnt have been in there in the
    >> first place! Those are very major potentially show stopping
    >> bugs. What If I get up one day, and I cant print? Or build
    >> isos? That sounds minor to you, but thats a big thing if say,
    >> the linux box is a network print server, or, its the
    >> workstation for the guy in the company who builds the iso. And,
    >> no, "use the previous kernel" isnt a good excuse. Because what
    >> if you get hit with bugs back to back? You'll have to go back
    >> to some kernel way way back. Like 2.4.2. The Kernel needs
    >> Quality Assurance.

    Mohammad> Yes, this is a QA problem. But also .. if you're a smart
    Mohammad> net/system admin, you don't go out installing a just
    Mohammad> released kernel without letting others bang on it or run
    Mohammad> it on some test servers. Where I work, I insist the
    Mohammad> admins wait at least 1-2 weeks before going to the
    Mohammad> latest release unless there's some huge security fix.

I must say I'm seriously annoyed with the 2.4-tree so far. As far as
I'm concerned, 2.4 were obviously released too eary (or maybe the
2.5-tree should have been opened earlier so we wouldn't had this
VM-mess in the "stable" release). I'm not so annoyed for my own part
(I've mainly stayed on the 2.2 and will stay there until 2.4 looks
sane), but for a friend of mine.

Let me explain: I've had a few discussions with him that he should try
Linux for his needs, but it's always been "It looks complicated" and
"I can't play my games" that has stopped him. Now, a few weeks ago
lokigames released his favourite game and he ordered it, fully decided
to ditch Windows once and for all, like I did back in the summer if
-96 and so far I haven't regretted it. But then, 2.0 or 2.2 never felt
as shaky and unpredictable as 2.4 does right now.

So, off he went, installing RedHat only to find that his soundcard
didn't work reliable under the pre-built kernel. He decided not to
give up too fast and compiled his own kernel, several kernels in fact.
I don't remember how many, but I know that his attempt to try
2.4.15preX worked very well, except that his RAID-card refused to
work, so after much experimenting he found out that
2.4.13ac(something) could handle his soundcard and his RAID-card, but
only one of his CD-ROMs worked. Then the whole kernel finally blew up
on a VM-bug...

I must say that he really tried. He forsaked much of his spare time to
learn Linux and he learned a lot rather fast, but when a deadline on
one of his projects crept too close and he still didn't have a working
computer, he finally despaired and we lost him back to Windows XP.

It's obvious that stories like this really won't improve the
reputation of Linux...
