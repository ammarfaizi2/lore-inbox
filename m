Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131531AbQLVLwi>; Fri, 22 Dec 2000 06:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131992AbQLVLw2>; Fri, 22 Dec 2000 06:52:28 -0500
Received: from smtp7.xs4all.nl ([194.109.127.133]:29384 "EHLO smtp7.xs4all.nl")
	by vger.kernel.org with ESMTP id <S131531AbQLVLwP>;
	Fri, 22 Dec 2000 06:52:15 -0500
Date: Fri, 22 Dec 2000 11:21:11 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm 2.2.18 (stock kernel) process hara-kiri's
Message-ID: <20001222112111.A678@grobbebol.xs4all.nl>
In-Reply-To: <20001222001909.A20766@grobbebol.xs4all.nl> <E149G5N-0003qF-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E149G5N-0003qF-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 22, 2000 at 12:29:23AM +0000
X-OS: Linux grobbebol 2.2.19pre3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 12:29:23AM +0000, Alan Cox wrote:
> > I thought the 2.2.18 vm would be better :-)... nver have seen so much
> > VM: do_try_to_free_pages failed for...  messages.
> 
> Try 2.2.19pre2 or higher

ok, will monitor this. uname -a now :

Linux grobbebol 2.2.19pre3 #1 SMP Fri Dec 22 09:07:45 GMT 2000 i686 unknown

at your service <grin>

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
