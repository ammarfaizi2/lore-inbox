Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289054AbSBKNKO>; Mon, 11 Feb 2002 08:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289020AbSBKNKF>; Mon, 11 Feb 2002 08:10:05 -0500
Received: from angband.namesys.com ([212.16.7.85]:35456 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S289013AbSBKNJw>; Mon, 11 Feb 2002 08:09:52 -0500
Date: Mon, 11 Feb 2002 16:09:48 +0300
From: Oleg Drokin <green@namesys.com>
To: Alex Riesen <fork0@users.sourceforge.net>
Cc: Luigi Genoni <kernel@Expansa.sns.it>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
Message-ID: <20020211160948.B7863@namesys.com>
In-Reply-To: <20020211085140.B27189@namesys.com> <Pine.LNX.4.44.0202111247270.21009-100000@Expansa.sns.it> <20020211131713.A8614@steel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020211131713.A8614@steel>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Feb 11, 2002 at 01:17:13PM +0100, Alex Riesen wrote:
> > I got the same with 2.5.4-pre1 on a  ATA66 disk,
> > chipset i810, PentiumIII with 256 MBRAM,
> > and then on Athlon 1300 Mhz, scsi disk, adaptec
> > 2940UW, 512MB RAM.
> > 
> > I saw then just after a reboot.
> > Those file has been opened three or four days before the reboot expect of
> > .history.
> > I got no messages, and, that is the most interesting thing, this
> > corruption was just for text file. I also edited some binary file with
> > kexedit and them have not been corrupted after the reboot.
Hm. Strange. This message have not appeared in my mailbox for some
reason.
.history may be corrupted if your partition was not unmounted properly
before reboot.

Bye,
    Oleg
