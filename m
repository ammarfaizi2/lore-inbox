Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbSLQRNm>; Tue, 17 Dec 2002 12:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbSLQRNm>; Tue, 17 Dec 2002 12:13:42 -0500
Received: from office-NAT.rockwellfirstpoint.com ([199.191.58.7]:9262 "EHLO
	ecsmtp01.rockwellfirstpoint.com") by vger.kernel.org with ESMTP
	id <S265250AbSLQRNi>; Tue, 17 Dec 2002 12:13:38 -0500
In-Reply-To: <Pine.LNX.4.10.10212170051360.31876-100000@master.linux-ide.org>
Subject: Re: i845PE chipset and 20276 Promise Controller boot failure with 2.4.20-ac2
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OF36283872.4A1C7061-ON86256C92.005F141D-86256C92.005F5A51@rockwellfirstpoint.com>
From: edward.kuns@rockwellfirstpoint.com
Date: Tue, 17 Dec 2002 11:25:05 -0600
X-MIMETrack: Serialize by Router on ECSMTP01/EC/Rockwell(Release 5.0.11  |July 24, 2002) at
 12/17/2002 11:21:52 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andre Hedrick <andre@linux-ide.org> wrote on 12/17/2002 02:52:44 AM:
> Really I am now curious as to when it first showed up.
> This i845 has been a royal pain!

Ha!  I believe you, having followed LKML for the past several months.  I
greatly appreciate all of the work you have done both on cleaning stuff up
structurally and on getting things to work.  I know just how much work that
is, having done it myself on smaller projects where I work.  (I imagine
that Motorola 68k family boards are rather easier to debug than the latest
and greatest Intel-type platform, however!  I've never had to deal with
BIOS or APIC or IRQ routing of any sort or .... well, you get the drift.
This is why I appreciate how much work and time you put into this.)

I'll play around with a bunch of 2.4 kernels from www.kernel.org to see if
I can find a place where it stopped working.  It's possible though that
none of them will work because the working kernel is a Red Hat 8.0 one with
its (unknown to me only because I haven't investigated it) collection of
patches.  I'll do the experiment and let you know tomorrow if I can find a
"it worked here but stopped working here" point.  If I get the time I'll
also try out the latest 2.5 series...

      Thanks

      Eddie

P.S.  Andre, I assumed you would not want or need to be CC'd.  I hope that
is the correct assumption.  :)

--
Edward Kuns
Technical Staff Member
Rockwell FirstPoint Contact
300 Bauman Ct
Wood Dale, IL  60191
Phone: +1-630-227-8070
Fax: +1-630-227-8040
edward.kuns@rockwellfirstpoint.com
www.rockwellfirstpoint.com

This e-mail is intended solely for the person or entity to which it is
addressed and may contain confidential or privileged material.  Any
duplication,  dissemination, action taken in reliance upon, or other use of
this information by persons or entities other than the intended recipient
is prohibited and may violate applicable law.  If this e-mail has been
received in error, please notify the sender and delete the information from
your system.


