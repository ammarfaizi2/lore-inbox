Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130400AbRAWUUF>; Tue, 23 Jan 2001 15:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130391AbRAWUTq>; Tue, 23 Jan 2001 15:19:46 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:1030 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129982AbRAWUTi>; Tue, 23 Jan 2001 15:19:38 -0500
Date: Tue, 23 Jan 2001 15:20:56 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Torrey Hoffman <torrey.hoffman@myrio.com>
cc: "Trever L. Adams" <trever_Adams@bigfoot.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RE: Total loss with 2.4.0 (release) [off topic now...]
In-Reply-To: <4461B4112BDB2A4FB5635DE1995874320223E1@mail0.myrio.com>
Message-ID: <Pine.LNX.4.32.0101231517270.7610-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001, Torrey Hoffman wrote:

>>I know if you have a 8G drive or larger, and install NT4 on it it
>>will fry everything entirely unless you stand on your head and
>>read about 50 MS kb articles.  Thankfully, I will _never_ have to
>>encounter this sort of thing again though.  ;o)
>
>If you have to share a machine with a Microsoft OS, the best thing is to
>install the Microsoft OS first.  That way it can set up the partition tables
>however it likes.  Just leave enough hard drive space free.
>
>Then install Linux.  This has several advantages - you can more easily set
>up Grub or Lilo to dual boot, and Linux can deal with whatever Microsoft's
>partition table flavor of the year is.  The Microsoft OS is less likely to
>become confused and violently lash out using that approach :-)

I absolutely and totally agree.  I strongly recommend this to
anyone at all.  If someone MUST share between NT and Linux,
install NT on partition 1 first, and make sure to grab ATAPI.SYS
update from MS first if you value any data on the drive and it
is >8Gb.  ;o)


>Another note: If dual-booting Windows 2000, upgrade to service pack 1 before
>installing Linux.  I was able to blue-screen W2K before SP1 by starting
>their disk management tool on a disk with dozens of Linux partitions.  And I
>agree - I am thankful that I will never have to deal with this again either.

All my new machines are getting straight Linux installs, no dual
boot anything except perhaps multiple boots of different versions
of Red Hat.  Only one machine shall have Windows on it, and only
until the remaining uses of it are available in Linux.  I
suspect it wont be too long.  ;o)


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
Looking for Linux software?   http://freshmeat.net  http://www.rpmfind.net
http://filewatcher.org  http://www.coldstorage.org  http://sourceforge.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
