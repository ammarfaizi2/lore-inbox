Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129683AbQLFWbN>; Wed, 6 Dec 2000 17:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbQLFWbD>; Wed, 6 Dec 2000 17:31:03 -0500
Received: from gateway.sequent.com ([192.148.1.10]:57826 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S129683AbQLFWau>; Wed, 6 Dec 2000 17:30:50 -0500
Date: Wed, 6 Dec 2000 14:00:12 -0800
From: Mike Kravetz <mkravetz@sequent.com>
To: Ragnar Hojland Espinosa <ragnar_hojland@eresmas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test12pre6: BUG in schedule (sched.c, 115)
Message-ID: <20001206140012.B2215@w-mikek.des.sequent.com>
In-Reply-To: <20001206195908.A190@lightside.2y.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001206195908.A190@lightside.2y.net>; from ragnar_hojland@eresmas.com on Wed, Dec 06, 2000 at 07:59:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ragnar,

Are you sure that was line 115?  Could it have been line 515?
Also, do you have any Oops data?

Thanks,
-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
15450 SW Koll Parkway
Beaverton, OR 97006-6063                     (503)578-3494


On Wed, Dec 06, 2000 at 07:59:08PM +0100, Ragnar Hojland Espinosa wrote:
> as per subject.. BUG in schedule (sched.c, 115)
> -- 
> ____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
> \ o.O|                                                   2F0D27DE025BE2302C
>  =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
>    U     chaos and madness await thee at its end."       hkp://keys.pgp.com
> 
> Handle via comment channels only.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
