Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130251AbRA1FXJ>; Sun, 28 Jan 2001 00:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130195AbRA1FW7>; Sun, 28 Jan 2001 00:22:59 -0500
Received: from slkcpop2.slkc.uswest.net ([206.81.128.2]:30482 "HELO
	slkcpop2.slkc.uswest.net") by vger.kernel.org with SMTP
	id <S130251AbRA1FWr>; Sun, 28 Jan 2001 00:22:47 -0500
Message-ID: <3A73B191.39685459@qwest.net>
Date: Sat, 27 Jan 2001 22:43:46 -0700
From: Jacob Anawalt <anawaltaj@qwest.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Pitts <mpitts@suite224.net>, Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Knowing what options a kernel was compiled with
In-Reply-To: <web-2874335@suite224.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew and Keith,

Thank you to both of you for your input, info, and quick responses. I
just wanted to make shure there weren't tricks still in the bag that I
hadn't learned about in this area. I'll look for the config file.

Jacob Anawalt

Matthew Pitts wrote:

> On Sun, 28 Jan 2001 16:06:57 +1100
>  Keith Owens <kaos@ocs.com.au> wrote:
> > On Sat, 27 Jan 2001 22:21:41 -0700,
> > Jacob Anawalt <anawaltaj@qwest.net> wrote:
> > >Is there a way to know what options a running kernel was
> > compiled with,
> > >if you dont have access to the source or configure files
> > it was compiled
> > >off of?
> >
> > No.  You have to insist that whoever distributes the
> > kernel binary also
> > distributes the .config file that it was compiled with.
> >
> > Don't bother arguing that the kernel should record this
> > info, it has
> > been discussed before and rejected.  This is a problem
> > for the
> > distributors, not for the kernel.
> Keith and Jacob,
> Some distributions DO include the config. It may be located
> in the /boot dir with a name CONFIG-2.2.10 or similar. I
> know that Caldera 2.3 shiped that way(2.4 may also). If you
> have the install CDROM, the kernel source install may have
> it (e.g. Linux-Mandrake 7.x).
>
> Matthew
> mpitts@suite224.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
