Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135909AbREASzP>; Tue, 1 May 2001 14:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136505AbREASzF>; Tue, 1 May 2001 14:55:05 -0400
Received: from femail2.sdc1.sfba.home.com ([24.0.95.82]:9390 "EHLO
	femail2.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S135909AbREASzB>; Tue, 1 May 2001 14:55:01 -0400
Message-ID: <3AEF067F.C1535BAA@home.com>
Date: Tue, 01 May 2001 11:54:56 -0700
From: Seth Goldberg <bergsoft@home.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: DISCOVERED! Cause of Athlon/VIA KX133 Instability
In-Reply-To: <Pine.LNX.4.33.0105011801380.2060-100000@dogfox.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will Newton wrote:

  I Should clarify that this is the KX133A chipset.  In any event,
there are a bunch of people having this problem (check out the list
archives).  I just upgraded to this IWILL board from an Abit KA7-RAID
(which worked with no problem), so I'm just trying tofgure it out :)

 -Seth

> 
> > is exhibiting weird behavior under K7 optimizations. The jist of my
> > research is that compiling a kernel for ANY CPU with the Athlon MMX
> > optimization
> > *AND* 3DNOW results in massive amounts of oops'es and total system
> > instability. The following is what I've tried:
> 
> With:
> 
> Athlon 700
> Asus K7V (KX133 based)
> 
> I have been running Athlon based kernels for months, no problems (well,
> none like you mention).
> 
> gcc 2.96-81 BTW
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
