Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277802AbRJLRaG>; Fri, 12 Oct 2001 13:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277799AbRJLR34>; Fri, 12 Oct 2001 13:29:56 -0400
Received: from bitmover.com ([192.132.92.2]:3543 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S277798AbRJLR3v>;
	Fri, 12 Oct 2001 13:29:51 -0400
Date: Fri, 12 Oct 2001 10:30:19 -0700
From: Larry McVoy <lm@bitmover.com>
To: Mike Borrelli <mike@nerv-9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No love for the PPC
Message-ID: <20011012103019.J30657@work.bitmover.com>
Mail-Followup-To: Mike Borrelli <mike@nerv-9.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0110121002200.13818-100000@asuka.nerv-9.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0110121002200.13818-100000@asuka.nerv-9.net>; from mike@nerv-9.net on Fri, Oct 12, 2001 at 10:08:39AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try the BK PPC trees at 

	http://ppc.bkbits.net

you can clone any one of those with a

	bk clone http://ppc.bkbits.net/<TREE_NAME>

you can get BK at http://www.bitmover.com/download

On Fri, Oct 12, 2001 at 10:08:39AM -0700, Mike Borrelli wrote:
> I'm sorry about the tone of this e-mail, but it is somewhat painful when,
> after downloading a new kernel to play with, it doesn't compile on the
> ppc.  It isn't even big problems either.  A single line (#include
> <linux/pm.h>) is missing from pc_keyb.c and has been for at least three
> -ac releases.  Now, process.c in arch/ppc/kernel/ dies from an undeclared
> identifier (init_mmap).
> 
> I'm sure the appropriate response would be to fix them myself, but I don't
> know enough about the kernel or the ppc arhitecture.  I'm also sure that
> if Theo (or anyone like him) was to read this s/he would tell me to stop
> whining.
> 
> Anyway, the real question is, why does the ppc arhitecture /always/ break
> between versions?
> 
> I'll stop complaining now.
> 
> Regards,
> -Mike
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
