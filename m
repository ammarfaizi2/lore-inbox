Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129810AbRAZV5b>; Fri, 26 Jan 2001 16:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130329AbRAZV5J>; Fri, 26 Jan 2001 16:57:09 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:1540 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129810AbRAZV5C>; Fri, 26 Jan 2001 16:57:02 -0500
Date: Fri, 26 Jan 2001 16:40:28 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Kjartan Maraas <kmaraas@online.no>
cc: "Trever L. Adams" <trever_Adams@bigfoot.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Total loss with 2.4.0 (release)
In-Reply-To: <200101251354.OAA08991@mail50.fg.online.no>
Message-ID: <Pine.LNX.4.32.0101261611300.791-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jan 2001, Kjartan Maraas wrote:

>> Whwnever you install/upgrade any OS and especially M$ ones on a
>> multiboot machine, you should always ensure ahead of time that
>> they will play nicely together, agree on geometry translation
>> schemes, partitioning schemes, etc, and that any option to take
>> over the whole machine is turned off.  Windows NT defaults to
>> "fry the whole disk", but I don't know about ME or W2K as they
>> are IMHO just bloat + new pictures, etc..
>>
>> I know if you have a 8G drive or larger, and install NT4 on it it
>> will fry everything entirely unless you stand on your head and
>> read about 50 MS kb articles.  Thankfully, I will _never_ have to
>> encounter this sort of thing again though.  ;o)
>>
>I'm sitting here doing an install of NT4 on a box with a 10 gig
>
>drive containing three partitions (two W2K and one ext2). The nice NT4
>install asked me nicely which partition I wanted to install on:
>NTFS      4GB
>Unknown 1 GB (ext2)
>NTFS      5GB
>
>This doesn't look like "default to fry everything" to me. It's nicer if
>we stick to the facts...

Yes, lets do that.  Lets stick to some facts:

1) One single person (you) not having a problem does not mean in
   any way that this is the way it occurs for 100% of the
   userbase.  There are way too many different computer systems
   in use today, with varying hardware problems, software
   problems, etc.  Making a carte blanche statement which more or
   less says "it works for me so you don't know what you're
   talking about" is arrogant and does not help anyone.

2) I've installed systems like this a LOT and _have_ had problems
   with NT4 on ALL of them that had disks larger than 8G.

3) The solution to the problems I (and numerous others have had)
   for these NT related problems are acknowledged problems with
   Microsuck NT, and are dealt with by Microsoft Knowledgebase
   articles.

These knowledgebase articles point out many problems NT has with
large disks both during install time as well as after install
time, numerous problems NT has with partition sizes and
locations, especially on large IDE hard disks.

Due to these problems, if you do not follow exact procedures
carefully, and have an OS installed on such a disk, you can and
most likely _will_ fry all OS's and data when installing Windows
NT4 (both WS and SRV).

Actually, just so we're being "factual" here, and so this thread
doesn't go on to the "oh yeah? lets see page numbers then" stage,
I will spend the 10 minutes to cut this thread dead right now for
everyone.

For your viewing pleasure - the "facts":

Afticle Q114841: Windows NT Boot Process and Hard Disk Constraints
http://support.microsoft.com/support/kb/articles/Q114/8/41.ASP

Article Q119497: Boot Partition Created During Setup Limited to 4 Gigabytes
http://support.microsoft.com/support/kb/articles/Q119/4/97.ASP

Article Q197667: Installing Windows NT on a Large IDE Hard Disk
http://support.microsoft.com/support/kb/articles/Q197/6/67.ASP

Article Q224526: Windows NT 4.0 Supports Maximum of 7.8-GB System Partition
http://support.microsoft.com/support/kb/articles/Q224/5/26.ASP

Fortunately I still had the above links bookmarked so it was
painless nor time consuming to educate you.

Are there any other facts that you'd like to discuss?
Preferably not ones about Microsoft... I hate their damned
website.  Doesn't work with Mozilla either...  (custom build of
a CVS snapshot before you try to say "mozilla works for me on
their site")...






----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
If you're interested in computer security, and want to stay on top of the
latest security exploits, and other information, visit:

http://www.securityfocus.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
