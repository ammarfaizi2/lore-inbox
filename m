Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274248AbRI3XRY>; Sun, 30 Sep 2001 19:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274249AbRI3XRN>; Sun, 30 Sep 2001 19:17:13 -0400
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:44162 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S274248AbRI3XRC>;
	Sun, 30 Sep 2001 19:17:02 -0400
Message-ID: <3BB7A6DD.56870FF6@pobox.com>
Date: Sun, 30 Sep 2001 16:12:29 -0700
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.11-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "M. Edward Borasky" <znmeb@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [OT] New Anti-Terrorism Law makes "hacking" punishable by life in prison
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBEEOFDNAA.znmeb@aracnet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"M. Edward Borasky" wrote:

> We need to distinguish between Linux/Apache and other-UNIX/Apache.
> Specifically, there's at least Solaris, Tru64 and AIX besides Linux in this
> market.

Yes, IIRC total apache = 60%, linux/apache = 33%

> It isn't just IIS; the Nimda beast exploited, IIRC, 18 separate
> vulnerabilities in the Windows / IIS complex, including shared files.

Sure are a lot of vulnerabilities there...

> I've actually heard of cases where *Linux* systems exporting filesystems
> with Samba had Nimda code stuffed down their throats!

Define "stuffed down their throats".

We have samba servers here (Linux, Solaris, HPUX)
and while the windows clients stored infected files on
the samba fileservers, the servers themselves were
totally unaffected.

> If this code had been
> Linux-executable rather than Windows-executable -- if the virus had been
> smart enough to know it was dealing with a Samba rather than a Windows share
> and had been able to differentiate between Windows executables and Linux
> executables --

Yes, the command most likely would fail, since
it would run as the remote samba user, not
root.

> hmmm ... do you see what I'm getting at??? In other words,
> UNIX systems of *all* stripes that export filesystems with Samba need to
> track mods to executables just like a virus scanner does on a Windows
> system. *That's* what I mean by vigilance.

Oh yes, vigilance is indeed due, but please let's
not lump all OSes together and pretend there
are no differences!

> The security features are there in Windows if the users and sysadmins are
> willing to implement them.

Shipped very unsecure, and most windows
programs would cease to operate or could
not be installed if the security measures
were implemented.

> Windows NT has had C2 available for quite some
> time; they couldn't sell to DOD if they didn't.

Ah yes, the checklist item - C2, as long as there is
no floppy disk, and no network interface - you install
either of those items, and no more C2 for windows.

The difference is, there are Unix systems that are
both secure, and fully functional.

> I don't see any such advantage.

OK, then.

We are not living in the same world.

cu

jjs

