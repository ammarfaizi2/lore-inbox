Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267776AbTBGJ4F>; Fri, 7 Feb 2003 04:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267777AbTBGJ4F>; Fri, 7 Feb 2003 04:56:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18700 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267776AbTBGJ4D>; Fri, 7 Feb 2003 04:56:03 -0500
Date: Fri, 7 Feb 2003 10:05:40 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Restore module support.
Message-ID: <20030207100540.B23442@flint.arm.linux.org.uk>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Roman Zippel <zippel@linux-m68k.org>,
	Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
References: <20030207084947.A31572C0A8@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030207084947.A31572C0A8@lists.samba.org>; from rusty@rustcorp.com.au on Fri, Feb 07, 2003 at 07:26:50PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 07:26:50PM +1100, Rusty Russell wrote:
> Actually, I must be really confused.  I thought ARM was already
> complete.
> 
> Anyway, here's a version which simply does what the usermode one did,
> if you decide to take the "fix it later" approach.

Rusty, as I said, I already have a patch for this approach.  Its the
second approach that I'd prefer to get working.

Also, if you see the message-id I posted in my mail just 5 minutes ago,
you'll see why the existing code does not work.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

