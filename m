Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281012AbRKTKWv>; Tue, 20 Nov 2001 05:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281015AbRKTKWl>; Tue, 20 Nov 2001 05:22:41 -0500
Received: from web10407.mail.yahoo.com ([216.136.130.99]:4872 "HELO
	web10407.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S281012AbRKTKWd>; Tue, 20 Nov 2001 05:22:33 -0500
Message-ID: <20011120102232.69226.qmail@web10407.mail.yahoo.com>
Date: Tue, 20 Nov 2001 21:22:32 +1100 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: Strange HD light with 2.2.19
To: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BFA0E1F.4010708@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> is there a difference in disk performance running
> 2.4 and
> 2.2 on this machine ?

I did not perform any test ; but I _feel_that_ it is
the same or almost the same. I prefer 2.2.19 for that
machine as this one has only 16Mb RAM; and 2.4.12-ac2
is thrashing to death when only running netscape, but
2.2.19 is fine.

> i think 2.2 isn't properly setting the DMA mode of
> the PIIX3, you might want to try something like
> hdparm -c3 -d1 /dev/hda

I will try tomorow when my friend is online ; we are
100Km away ... :-)


> or something like that.
> of course, if it breaks anything, it's not my fault
> (please do a "man hdparm" first...)
> 
> François


=====
S.KIEU

http://shopping.yahoo.com.au - Yahoo! Shopping
- Get organised for Christmas early this year!
