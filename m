Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275117AbRJFK0z>; Sat, 6 Oct 2001 06:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275119AbRJFK0g>; Sat, 6 Oct 2001 06:26:36 -0400
Received: from t2.redhat.com ([199.183.24.243]:34042 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S275117AbRJFK0b>; Sat, 6 Oct 2001 06:26:31 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011006012430.B22173@flint.arm.linux.org.uk> 
In-Reply-To: <20011006012430.B22173@flint.arm.linux.org.uk>  <20011005231732.B19985@flint.arm.linux.org.uk> <20011005164408.A5469@thune.mrc-home.com> 
To: Russell King <rmk@arm.linux.org.uk>
Cc: Mike Castle <dalgoda@ix.netcom.com>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.11-pre4/drivers/mtd/bootldr.c does not compile 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Oct 2001 11:26:51 +0100
Message-ID: <7360.1002364011@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rmk@arm.linux.org.uk said:
>  It's setup that way in the latest MTD CVS tree.  Hopefully, it should
> be sync'd to Linus/Alan pretty soon (I think Alan already has it
> actually). 

Alan has it, yes. The patch to fix it was sent to Linus yesterday morning.

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0110.0/0974.html

--
dwmw2


