Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131672AbRDTXYW>; Fri, 20 Apr 2001 19:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131976AbRDTXYM>; Fri, 20 Apr 2001 19:24:12 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:14084 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S131672AbRDTXYB>; Fri, 20 Apr 2001 19:24:01 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Thomas Dodd <ted@cypress.com>, John Madden <weez@freelists.org>,
        "Petr Vandrovec" <VANDROVE@vc.cvut.cz>,
        Jesper Juhl <juhl@eisenstein.dk>, Dax Kelson <dax@gurulabs.com>,
        Aaron Lunansky <alunansky@rim.net>
cc: linux-kernel@vger.kernel.org
Message-ID: <86256A34.00808239.00@smtpnotes.altec.com>
Date: Fri, 20 Apr 2001 18:23:27 -0500
Subject: Re: Current status of NTFS support
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thanks to all who offered suggestions, both on the list and privately.  Rather
than answer them all individually, I'm going to respond in this one message.

Unfortunately the upgrade is not going to be done by me, but by our PC support
team.  Our laptops originally were set up with two FAT32 partitions:  a small
one for Win98 and applications, and a large one for data files.  I used FIPS to
carve off most of the large one for a swap partition and an ext2 partition.
Now, because of the larger space requirements of Win2000, they're going to wipe
out everything on the drives and start from scratch.  They'll be doing all our
laptops in a short period of time, and want to do all of them the same way.

>From everything I've been told here, it sounds like my best bet is to try and
talk them into replacing the two FAT32 partitions (which are contiguous) with
one big one and leave my Linux partitions alone.  That way I won't have to deal
with NTFS at all.  Fortunately, one of the PC support guys ought to be
sympathetic; he runs Linux at home and has asked me for advice in getting it set
up on his laptop, too.  I'll see if I can talk him into doing my machine
differently from the others.  I have to be careful, though; my Linux use at work
is tolerated, but not (yet) encouraged, and I don't want to rock the boat too
much.

Thanks again to everyone.

Wayne


