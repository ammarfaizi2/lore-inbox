Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283509AbRK3FgW>; Fri, 30 Nov 2001 00:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283512AbRK3FgD>; Fri, 30 Nov 2001 00:36:03 -0500
Received: from hkiteeri11.kemira.com ([137.33.254.111]:52971 "EHLO
	esmikko.fin.kemira.com") by vger.kernel.org with ESMTP
	id <S283509AbRK3Ff5> convert rfc822-to-8bit; Fri, 30 Nov 2001 00:35:57 -0500
Message-ID: <00fb01c17960$d052e780$5c172189@fin.kemira.com>
From: "Jarmo" <oh1mrr@nic.fi>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <A9497EC5D6C@vcnet.vc.cvut.cz>
Subject: Vs:       Re: My previous question about iwlib
Date: Fri, 30 Nov 2001 07:35:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: Petr Vandrovec <VANDROVE@vc.cvut.cz>
To: jarmo kettunen <oh1mrr@nic.fi>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, November 29, 2001 9:02 PM
Subject: Re: My previous question about iwlib


> > gcc -O2 -Wall -DGLIBC_HEADERS  -c iwlib.c
> > In file included from iwlib.c:11:

these headers, and distribute them with app - which is btw only
> correct way, as otherwise you cannot create userspace app which
> will support more than one API version (and iw used couple
> of incompatible APIs in the past...).
>                                     Best regards,
>                                             Petr Vandrovec
>                                             vandrove@vc.cvut.cz
Thank for reply

Problem found and corrected...Suppose to get rid of old eyeglases..Buy
new with gain 7..-)
Or cosider to syop by some reading cource....

I was too heated to get new stuff on production and read too hastly
documents.
In makefile was possibility to choose right version of glibc...When found
that..voila'.
Thanks for partisipating....

Jarmo
 

