Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132130AbRAQVWE>; Wed, 17 Jan 2001 16:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132726AbRAQVVy>; Wed, 17 Jan 2001 16:21:54 -0500
Received: from Cantor.suse.de ([194.112.123.193]:26628 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132130AbRAQVVr>;
	Wed, 17 Jan 2001 16:21:47 -0500
Date: Wed, 17 Jan 2001 22:21:14 +0100
From: Andi Kleen <ak@suse.de>
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 + iproute2
Message-ID: <20010117222114.A6587@gruyere.muc.suse.de>
In-Reply-To: <14945.26991.35849.95234@pizda.ninka.net> <Pine.LNX.4.30.0101141013080.16469-100000@jdi.jdimedia.nl> <14945.28354.209720.579437@pizda.ninka.net> <20010114115215.A22550@gruyere.muc.suse.de> <20010117180433.A4979@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010117180433.A4979@almesberger.net>; from Werner.Almesberger@epfl.ch on Wed, Jan 17, 2001 at 06:04:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2001 at 06:04:33PM +0100, Werner Almesberger wrote:
> (See also ftp://icaftp.epfl.ch/pub/people/almesber/slides/tmp-tc.ps.gz
> The bitching starts on slide 11, some ideas for fixing the problem on
> slide 16, but heed the warning on slide 15.)

Thanks for the pointer. 

> 
> Besides that, I agree that we have far too many EINVALs in the kernel.
> Maybe we should just record file name and line number of the EINVAL
> in *current and add an eh?(2) system call ;-)

In the end you come to text strings, if you like it or not ;) 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
