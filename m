Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317308AbSFGQvz>; Fri, 7 Jun 2002 12:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317309AbSFGQvy>; Fri, 7 Jun 2002 12:51:54 -0400
Received: from web20809.mail.yahoo.com ([216.136.226.198]:25100 "HELO
	web20809.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317308AbSFGQvx>; Fri, 7 Jun 2002 12:51:53 -0400
Message-ID: <20020607165154.29392.qmail@web20809.mail.yahoo.com>
Date: Fri, 7 Jun 2002 09:51:54 -0700 (PDT)
From: Shane Walton <dsrelist@yahoo.com>
Subject: Re: Stream Lined Booting - SCSI Hold Up
To: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all for your replies.  Disabling the SCSI
reset helps much, but not enough.  I ended up loading
a RAM disk to start key binaries to fulfill this
requirement, afterwards I then load the aic7xxx module
and pivot_root to the real root.  My biggest problem
is
the BIOS level resets and POST.  Thanks for your time.

Regards,

=====
Shane M. Walton, Software Engineer
Digital System Resources, Inc.
dsrelist@yahoo.com : swalton@dsrnet.com
703.234.1674

__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
