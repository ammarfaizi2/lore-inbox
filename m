Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129117AbQKBXEJ>; Thu, 2 Nov 2000 18:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129193AbQKBXD7>; Thu, 2 Nov 2000 18:03:59 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:20998 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129117AbQKBXDz>; Thu, 2 Nov 2000 18:03:55 -0500
Message-ID: <3A01F1FC.675E9117@timpanogas.org>
Date: Thu, 02 Nov 2000 16:00:12 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmail.virusscreen.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <Pine.LNX.4.21.0011010122160.18143-100000@elte.hu> <3A01ECD2.76DE10FF@timpanogas.org> <3A01EED6.DB47198A@timpanogas.org> <00110301140700.00398@linux1.home.bogus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Davide Libenzi wrote:
> 
> On Thu, 02 Nov 2000, Jeff V. Merkey wrote:
> > "Jeff V. Merkey" wrote:
> > This code fragment will generate an AGI condition:
> >
> > mov   eax, addr
> > mov   [eax].offset, ebx
> 
> I had already posted the correction.
> It was clear that You had forgot something coz Your old code fragment did not
> generate AGI.

typing too fast late at night.  I described it correctly, I just forgot
to add the register indirection.  

:-)

Jeff

> 
> - Davide
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
