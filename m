Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbRCHUKI>; Thu, 8 Mar 2001 15:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129569AbRCHUJu>; Thu, 8 Mar 2001 15:09:50 -0500
Received: from patan.Sun.COM ([192.18.98.43]:40957 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S129567AbRCHUJk>;
	Thu, 8 Mar 2001 15:09:40 -0500
Message-ID: <3AA7BDEE.3D39BACF@sun.com>
Date: Thu, 08 Mar 2001 12:14:22 -0500
From: ludovic <ludovic.fernandez@sun.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zdenek Kabelac <kabi@informatics.muni.cz>
CC: linux-kernel@vger.kernel.org
Subject: NOISE: [Fwd: Re: static scheduling - SCHED_IDLE?]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is noise guys, skip it....


I will have appreciate that you apology to me, not to Alan.

For you concern, I love black humor, I do make nonsense most
of the time (but I hope to learn from my mistakes) and yes
I work for SUN.

Regarding the 2.5 kernel being available, I don't honestly
know but I will suggest you stay with 2.4 for a while, you
still have some stuff to learn.

Ludo.



-------- Original Message --------
Subject: Re: static scheduling - SCHED_IDLE?
Date: Thu, 8 Mar 2001 13:26:50 +0100
From: Zdenek Kabelac <kabi@informatics.muni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Zdenek Kabelac <kabi@i.am>, ludovic <ludovic.fernandez@sun.com>
In-Reply-To: <3AA76A53.CEC1B234@i.am>
<E14azTH-0002sI-00@the-village.bc.nu>

On Thu, Mar 08, 2001 at 12:24:41PM +0000, Alan Cox wrote:
> > > locking problem you mention but the idea of background low priority
> > > threads that run when the machine is really idle is also not this
> > > simple.
> > 
> > You seem to have a sence for black humor right :) ?
> > As this is purely a complete nonsence 
> > - you were talking about M$Win3.11 right ?
> > (are you really the employ of Sun ??)
> 
> We are not currently pre-empting in kernel space (SMP effectively does most of
> this). Its a 2.5 change being discussed. Since the kernel is a controlled
> environment its not a big deal, and userspace is all pre-empted.

Oh I've missed the context that it was just about kernel space - oops 
sorry

Anyway where is the wishlist for 2.5 publically available ?

-- 
             There are three types of people in the world:
               those who can count, and those who can't.
  Zdenek Kabelac  http://i.am/kabi/ kabi@i.am {debian.org; fi.muni.cz}
