Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274766AbRJFAYX>; Fri, 5 Oct 2001 20:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274774AbRJFAYP>; Fri, 5 Oct 2001 20:24:15 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:10113 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S274766AbRJFAYC>; Fri, 5 Oct 2001 20:24:02 -0400
Date: Sat, 6 Oct 2001 01:24:30 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.11-pre4/drivers/mtd/bootldr.c does not compile
Message-ID: <20011006012430.B22173@flint.arm.linux.org.uk>
In-Reply-To: <20011005231732.B19985@flint.arm.linux.org.uk> <20011005164408.A5469@thune.mrc-home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011005164408.A5469@thune.mrc-home.com>; from dalgoda@ix.netcom.com on Fri, Oct 05, 2001 at 04:44:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 04:44:08PM -0700, Mike Castle wrote:
> On Fri, Oct 05, 2001 at 11:17:32PM +0100, Russell King wrote:
> > Firstly, its ARM only.  Secondly, Compaq decided that a partition table in
> 
> Can it be set up so that the MTD stuff only shows up for ARM and not for
> x86?

It's setup that way in the latest MTD CVS tree.  Hopefully, it should be
sync'd to Linus/Alan pretty soon (I think Alan already has it actually).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

