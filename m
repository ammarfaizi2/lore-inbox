Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbSLMJKP>; Fri, 13 Dec 2002 04:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261663AbSLMJKP>; Fri, 13 Dec 2002 04:10:15 -0500
Received: from mail.webmaster.com ([216.152.64.131]:43515 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S261646AbSLMJKL> convert rfc822-to-8bit; Fri, 13 Dec 2002 04:10:11 -0500
From: David Schwartz <davids@webmaster.com>
To: <root@chaos.analogic.com>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Fri, 13 Dec 2002 01:18:01 -0800
In-Reply-To: <Pine.LNX.3.95.1021211214435.28053A-100000@chaos.analogic.com>
Subject: Re: Is this going to be true ?
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Message-ID: <20021213091800.AAA29955@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Dec 2002 22:16:19 -0500 (EST), Richard B. Johnson wrote:

>I  wish to hell it was FUD. I have watched all the Sun Workstations
>at work be replaced with Windows/2000/Professional PCs. I have watched
>all the 'nix programmers leave, replaced by Internet junkies who
>don't (can't) write any code. In spite of the fact that don't actually
>use their machines for any work, about 10 percent out of 600++ are
>down at any one moment, most always to "reload Windows".

	I think an idiot can screw up a Linux machine as easily as one can screw up 
a Windows machine.

>Just to get this Windows machine up at home, tonight, I had to reconfigure
>the network because it "forgot" everything it knew  last night
>about the LAN.

	Hmm, IP address, netmask, default router. Maybe nameservers too. Did that 
take you more than a minute?

>I use Windows at home only because I compose music
>using Cake-walk and it hasn't been ported to Linux. It is a corrupt,
>defective, dastardly, incredibly obnoxious operating system that
>has no redeeming qualities at all.

	What about I/O completion ports? What about operating-system code to 
automatically keep the number of running threads close to the number of CPUs?

>Virtually every Windows program
>has horrible bugs that make it barely usable.

	This is largely because they're written by one of two types of people:

	1) Inexperienced programmers. They're attracted to Windows because it really 
is easier to get things up and running. (Of course, this ease is deceptive. 
Hence the crappy software.)

	2) Experienced UNIX programmers who aren't willing to learn how to do things 
right on Windows. An example of this is any Windows application that uses 
'select'.

	Microsoft has made it easier for people to write software, so more people 
do. Since there's more software of all kinds, there's going to be more junk. 
90% of anything is crap.

>Even Microsoft Visual
>C/C++ will take down the whole machine when it encounters source files
>that don't have a CR/LF sequence as an end-of-line (accidental Unix LF
>files).

	I have used Visual C++ for about 4 years now on a weekly basis at least. The 
vast majority of my source files have Unix line endings. I've never had it 
take down my machine. In any event, there are things you can do that will 
take down a Linux machine. Fix it or don't do that. ;)

>It is the worse programming environment, ever, and I have even
>used a MDS-200 "Green Monster" during my 35 years as an Engineer.

	I like joe/make/gcc best myself. But I develop mostly server apps, so a GUI 
is just in the way.

>This machine used to have two CPUs. I had to take one out when I
>changed it from a Linux machine to a Windows machine. Two CPUs under
>Windows will trash the file-system so it won't boot if it's been
>up for over an hour.

	I've used a dual-CPU Windows 2000 machine as my primary desktop machine 
(though mostly to run two rxvt's into a Linux machine.) since Windows 2000 
came out. I have not lost a single file. I can't say the same for my Linux 
machine which has lost quite a few. (Though none since ext3 became stable and 
I started using it.)

>I have reloaded Windows on my two Windows machines
>at least once per week, usually more often than that. My Linux machines
>run until I break them by installing a buggy driver. Even then, I
>can reboot and nothing bad happens to the file-systems.

	NTFS has been totally stable for me. I've never heard anyone report any 
repeatable problems with it (though I have heard tales of a very small number 
of spactacular events). Your experiences don't seem to be common.

	My three kids have 98SE and ME machines. They beat the heck out of them. 
None of them have ever lost a file that wasn't modified within seconds of a 
power loss or crash. (Though they have accidentally installed SpyWare that 
has taken me *many* hours to worm out of the OS. *ugh* Linux at least has 
sane permissions.)

>Once Windows fails to boot, you can reinstall from a CD/ROM, but
>it won't boot after the reinstall! You need to make Windows "think"
>that the boot disk is new by deleting all partitions before you
>"reinstall" Windows or the new installation won't boot.

	Huh? You can do a repair installation of NT or 2000 from the CDROM and it 
just works, though you may lose all your security updates and whatnot. I 
reinstalled ME in place over a previous installation about two weeks ago and 
it just worked.

>Microsoft has trained the "new breed" of Engineer that bugs are
>normal and a natural consequence of using computers. This has
>helped destroy software development as an Engineering endeavor and
>substituted in its place, a developmental crap-game.

	Absolutely. I entirely agree with that paragraph. But it says nothing about 
the OS. This is very similar to blaming AOL for the condition of USENET. Yes, 
they lowered the bar so anyone can post on USENET and as a result there's a 
lot of crap there. Does this mean it's bad to make it easy to get online?

	Should it be difficult to develop software? So that this way only those who 
are really competent can do it?

	By the way, just as an off-the-cuff guesstimate, how many bugs do you think 
there are in the Linux kernel? Say the latest 2.4 series stable release. If I 
order the latest version of RedHat or Slackware, how many bugs would you 
estimate are in it, total?

	DS


