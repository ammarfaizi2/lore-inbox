Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130262AbQJ2C6t>; Sat, 28 Oct 2000 22:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130735AbQJ2C6b>; Sat, 28 Oct 2000 22:58:31 -0400
Received: from cmailg7.svr.pol.co.uk ([195.92.195.177]:48432 "EHLO
	cmailg7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S130262AbQJ2C6Z>; Sat, 28 Oct 2000 22:58:25 -0400
Date: Sun, 29 Oct 2000 02:54:21 +0000
To: linux-kernel@vger.kernel.org
Subject: Re: test10-6: can't mount root partition
Message-ID: <20001029025420.C3523@stefan.fleiter.rhoen.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <381216085.972784983226.JavaMail.root@web641-wra.mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <381216085.972784983226.JavaMail.root@web641-wra.mail.com>; from fdavis112@juno.com on Sat, Oct 28, 2000 at 10:03:00PM -0400
From: Stefan Fleiter <stefan.fleiter@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2000 at 10:03:00PM -0400 Frank Davis wrote:

> I compiled 2.4.0-test10-6 fine....modules and all, and for some reason I
> can't mount my root partition on boot..I get a VFS kernel panic.

> #
> # Automatically generated make config: don't edit
> #
[..]
> #
> # ATA/IDE/MFM/RLL support
> #
> CONFIG_IDE=m
> 
> #
> # IDE, ATA and ATAPI Block devices
> #
> CONFIG_BLK_DEV_IDE=m


How about compiling these into the Kernel so that it realy can find it's
modules?


Stefan

-- 
  friendly greetings from Chelmsford/Britain

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
