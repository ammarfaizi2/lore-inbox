Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286362AbRL0Q6g>; Thu, 27 Dec 2001 11:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286361AbRL0Q60>; Thu, 27 Dec 2001 11:58:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58641 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S286356AbRL0Q6O>; Thu, 27 Dec 2001 11:58:14 -0500
Date: Thu, 27 Dec 2001 16:57:52 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Dana Lacoste <dana.lacoste@peregrine.com>,
        "'Eyal Sohya'" <linuz_kernel_q@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011227165752.A19618@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33L.0112271353370.12225-100000@duckman.distro.conectiva> <E16JdTa-0005zm-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16JdTa-0005zm-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 27, 2001 at 04:33:50PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 04:33:50PM +0000, Alan Cox wrote:
> Tridge wrote the system you describe, several years ago. Its called
> jitterbug but it doesnt help because Linus wont use it

Speaking as someone who _does_ use a system for tracking patches, I
believe that patch management systems are a right pain in the arse.

If the quality of patches aren't good, then it throws you into a problem.
You have to provide people with a reason why you discarded their patch,
which provides people with the perfect opportunity to immediately start
bugging you about exactly how to make it better.  If you get lots of
such patches, eventually you've got a mailbox of people wanting to know
how to make their patches better.

I envy Alan, Linus, and Marcelo for having the ability to silently drop
patches and wait for resends.  I personally don't believe a patch tracking
system makes life any easier.  Yes, it means you can't loose patches, but
it means you can't accidentally loose them on purpose.  This, imho, makes
life very much harder.

I hope this makes some sort of sense 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

