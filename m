Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263252AbREaWFb>; Thu, 31 May 2001 18:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263251AbREaWFW>; Thu, 31 May 2001 18:05:22 -0400
Received: from c526559-a.rchdsn1.tx.home.com ([24.0.107.130]:14976 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S263250AbREaWFF>; Thu, 31 May 2001 18:05:05 -0400
Message-ID: <3B16C002.E615CB80@home.com>
Date: Thu, 31 May 2001 17:04:50 -0500
From: Jordan <ledzep37@home.com>
Organization: University of Texas at Dallas - Student
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac5-preempt-reiserfs-3.6.25 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: unmount issues with 2.4.5-ac5, 3ware, and ReiserFS (was: 
 kernel-2.4.5
In-Reply-To: <E155a3W-00084H-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I'm staying on 2.4.5-ac5 for whatever it's worth (putting my life on the
> > line for the community? kidding...) and will report anything new. I will
> > be on the lookout for later ac patches, 2.4.6 ... and hopefully anything
> > anybody can share with me about this. I hope we'll see an end to these
> 
> Can you tell me if 2.4.5-ac4 is ok. ac5 has a small 'obviously correct'
> reiserfs module unload change that seems the first suspect
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I have seen this same problem with unmounting in 2.4.5-ac5, it was
perfectly fine in 2.4.5-ac3 and ac4.  I would guess the module unload is
what did it.

Jordan
