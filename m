Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129438AbRBTReD>; Tue, 20 Feb 2001 12:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129698AbRBTRdx>; Tue, 20 Feb 2001 12:33:53 -0500
Received: from www.pcxperience.com ([199.217.242.242]:29427 "EHLO
	gannon.zelda.pcxperience.com") by vger.kernel.org with ESMTP
	id <S129438AbRBTRdp>; Tue, 20 Feb 2001 12:33:45 -0500
Message-ID: <3A92AA23.9A0BAC43@pcxperience.com>
Date: Tue, 20 Feb 2001 11:32:19 -0600
From: "James A. Pattie" <james@pcxperience.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: klink@clouddancer.com, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs, 3 Raid1 arrays, 2.4.1 machine locks up
In-Reply-To: <3A91A6E7.1CB805C1@pcxperience.com> <96s93d$hh6$1@lennie.clouddancer.com> <20010220135326.013DF682A@mail.clouddancer.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colonel wrote:

> In clouddancer.list.kernel.owner, you wrote:
> >
> >I'm not subscribed to the kernel mailing list, so please cc any replies
> >to me.
> >
> >I'm building a firewall on a P133 with 48 MB of memory using RH 7.0,
> >latest updates, etc. and kernel 2.4.1.
> >I've built a customized install of RH (~200MB)  which I untar onto the
> >system after building my raid arrays, etc. via a Rescue CD which I
> >created using Timo's Rescue CD project.  The booting kernel is
> >2.4.1-ac10, no networking, raid compiled in but raid1 as a module
>
> Hmm, raid as a module was always a Bad Idea(tm) in the 2.2 "alpha"
> raid (which was misnamed and is 2.4 raid).  I suggest you change that
> and update, as I had no problems with 2.4.2-pre2/3, nor have any been
> posted to the raid list.

I just tried with 2.4.1-ac14, raid and raid1 compiled in and it did the
same thing.  I'm going to try to compile reiserfs in (if I have enough room
to still fit the kernel on the floppy with it's initial ramdisk, etc.) and
see what that does.


--
James A. Pattie
james@pcxperience.com

Linux  --  SysAdmin / Programmer
PC & Web Xperience, Inc.
http://www.pcxperience.com/



