Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265083AbSJWQ5Y>; Wed, 23 Oct 2002 12:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbSJWQ5H>; Wed, 23 Oct 2002 12:57:07 -0400
Received: from NODE1.HOSTING-NETWORK.COM ([66.186.193.1]:45585 "HELO
	hosting-network.com") by vger.kernel.org with SMTP
	id <S265095AbSJWQ4S>; Wed, 23 Oct 2002 12:56:18 -0400
Subject: Re: "Hearty AOL" for kexec
From: Torrey Hoffman <thoffman@arnor.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Pavel Roskin <proski@gnu.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <m1hefdrycl.fsf@frodo.biederman.org>
References: <Pine.LNX.4.44.0210230926320.9286-100000@localhost.localdomain>
	 <m1hefdrycl.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Oct 2002 09:58:01 -0700
Message-Id: <1035392282.30561.85.camel@rivendell.arnor.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 08:03, Eric W. Biederman wrote:
> Pavel Roskin <proski@gnu.org> writes:
[...]
> > I really want to see this feature in the kernel.  It is very useful in
> > embedded systems.  Just imagine loading the bootstrap kernel, then
> > downloading the new kernel over anything - HDLC, 802.11, USB, decrypting
> > it from flash etc.  Possibilities are infinite.
> 
> Yay!!!!  My first embedded developer who doesn't think it is silly to
> use a kernel as a bootloader :)  Or at least the first to admit they
> embedded developer.

Yeah, another AOL "Me Too" here - I'm an embedded linux developer and
think would be useful.  Being able to network boot the device, download
software to a flash, and then directly "kexec" boot from the kernel on
the flash would be nice. 

Anything that reduces dependencies on the BIOS is good.  I'd use this
feature if it was available.

Torrey Hoffman
thoffman@arnor.net
torrey.hoffman@myrio.com


