Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129195AbRBBOPe>; Fri, 2 Feb 2001 09:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129278AbRBBOPY>; Fri, 2 Feb 2001 09:15:24 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:18193 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S129195AbRBBOPU>; Fri, 2 Feb 2001 09:15:20 -0500
Message-Id: <200102021415.f12EF9O90629@aslan.scsiguy.com>
To: Wakko Warner <wakko@animx.eu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 lvm reiserfs adaptec 2940uw noritake alpha 
In-Reply-To: Your message of "Thu, 01 Feb 2001 21:17:49 EST."
             <20010201211749.A18693@animx.eu.org> 
Date: Fri, 02 Feb 2001 07:15:09 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If these 3 drives are on the adaptec aha-2940UW, I get an oops (reply for
>oops as I have to do it again and capture it) and the system locks (in
>interrupt handler, not syncing) when the copy completes.  I did a timed cp
>the first time and it took 3.5 minutes and crashed as soon as I got the
>prompt.  I'm assuming when the bufferes were flushed to the drives.
>

I would appreciate your feedback on the new aic7xxx driver found
here:

http://people.FreeBSD.org/~gibbs/linux/

--
Justin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
