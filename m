Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132587AbRDUNBF>; Sat, 21 Apr 2001 09:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132590AbRDUNAz>; Sat, 21 Apr 2001 09:00:55 -0400
Received: from www.nobugconsulting.ro ([212.93.142.140]:44806 "EHLO
	nobugconsulting.ro") by vger.kernel.org with ESMTP
	id <S132587AbRDUNAs>; Sat, 21 Apr 2001 09:00:48 -0400
X-RAV-AntiVirus: This e-mail has been scanned for viruses
Date: Sat, 21 Apr 2001 15:59:18 +0300 (EEST)
From: <lk@aniela.eu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A question about MMX.
In-Reply-To: <E14qw2g-0003WD-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0104211558380.18561-100000@ns1.aniela.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all who have responded my question.

Have a nice day!

/me


On Sat, 21 Apr 2001, Alan Cox wrote:

> > I have a Intel Pentium MMX machine and it acts as a mailserver, webserver,
> > ftp and I use X on it. I would like to know if the MMX instructions are
> > used by the kernel in this operations or not (networking, X etc.).
> 
> In almost all cases - no. The MMX instructions are mostly not useful. A few
> graphics operations benefit from them such as mpeg players but that is about
> it.
> 
> On the AMD and Cyrix machines 3Dnow is used extensively by Mesa (3D) and by
> many of the mp3 players. The winchip and athlon kernels also use mmx for
> block copies but this isnt a win in the pentium case.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

