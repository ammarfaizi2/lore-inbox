Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280051AbRKNDP3>; Tue, 13 Nov 2001 22:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280041AbRKNDPU>; Tue, 13 Nov 2001 22:15:20 -0500
Received: from sm10.texas.rr.com ([24.93.35.222]:22703 "EHLO sm10.texas.rr.com")
	by vger.kernel.org with ESMTP id <S280052AbRKNDPQ>;
	Tue, 13 Nov 2001 22:15:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marvin Justice <mjustice@austin.rr.com>
Reply-To: mjustice@austin.rr.com
To: linux-kernel@vger.kernel.org
Subject: Re: What Athlon chipset is most stable in Linux?
Date: Tue, 13 Nov 2001 21:19:49 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.30.0111131559580.8219-100000@rtlab.med.cornell.edu> <200111132137.fADLbdW01289@demai05.mw.mediaone.net> <20011113.183256.15406047.davem@redhat.com>
In-Reply-To: <20011113.183256.15406047.davem@redhat.com>
MIME-Version: 1.0
Message-Id: <01111321194902.00746@bozo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've acutally had next to no hangs on the Thunder K7 using a FireGL2 card 
--- if you don't mind spending $1000+ for high end 3D graphics :-) Stay away 
from nVidia for now; though I understand they're working on fixes for this 
chipset for their next driver release. 

On Tuesday 13 November 2001 08:32 pm, David S. Miller wrote:
>    From: Brian <hiryuu@envisiongames.net>
>    Date: Tue, 13 Nov 2001 16:37:28 -0500
>
>    We've tried a number of boards for our application servers and the only
> UP AMD DDR board I trust right now is the Gigabyte GA-7DX.  They are rock
> solid.
>
> Try to use the AGP slot with a Radeon of GeForce card, do something
> as simple as playing some quake with com_maxfps > 85 and the machine
> will hang solidly.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Marvin Justice
Software Developer
BOXX Technologies, Inc.
www.boxxtech.com
512-235-6318 (V)
512-835-0434 (F)
