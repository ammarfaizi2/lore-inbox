Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290078AbSAQRai>; Thu, 17 Jan 2002 12:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290079AbSAQRa2>; Thu, 17 Jan 2002 12:30:28 -0500
Received: from server.lan.com ([65.82.38.18]:9478 "EHLO lan.com")
	by vger.kernel.org with ESMTP id <S290078AbSAQRaX>;
	Thu, 17 Jan 2002 12:30:23 -0500
Date: Thu, 17 Jan 2002 12:30:17 -0500
From: Dennis Boylan <dennis@lan.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Calling EISA experts
Message-ID: <20020117123017.C8434@smp.lan.com>
In-Reply-To: <20020117015456.A628@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20020117015456.A628@thyrsus.com>; from esr@thyrsus.com on Thu, Jan 17, 2002 at 01:54:56AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a Micronics M54Pe dual Pentium EISA/PCI board.  It is the one
that I'm sending this message from.  I've also got some 486 motherboards
which have PCI and VLB.  I got rid of my EISA only 486 board.

I was looking at the pci.ids stuff, and haven't figured out how to modify
the entry for the Intel 82375EB to make it a PCI to EISA bridge and have
it discovered correctly in /proc/pci.

Let me know if there is anything I can do to help.

Thanks,
	Dennis Boylan
	dennis@lan.com
On Thu, Jan 17, 2002 at 01:54:56AM -0500, Eric S. Raymond wrote:
> Does anything in /proc or elswhere reliably register the presence of EISA?  
> 
> Failing that, have any motherboards existed that had both PCI and EISA slots?
> 
> (Yes, I have RTFD.  That's why I'm asking.)
> -- 
> 		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
> 
> Certainly one of the chief guarantees of freedom under any government,
> no matter how popular and respected, is the right of the citizens to
> keep and bear arms.  [...] the right of the citizens to bear arms is
> just one guarantee against arbitrary government and one more safeguard
> against a tyranny which now appears remote in America, but which
> historically has proved to be always possible.
>         -- Hubert H. Humphrey, 1960
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
