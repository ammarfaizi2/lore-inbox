Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132106AbRAaT5y>; Wed, 31 Jan 2001 14:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132290AbRAaT5n>; Wed, 31 Jan 2001 14:57:43 -0500
Received: from [209.143.110.29] ([209.143.110.29]:28941 "HELO
	mail.the-rileys.net") by vger.kernel.org with SMTP
	id <S132106AbRAaT5g>; Wed, 31 Jan 2001 14:57:36 -0500
Message-ID: <3A786E7E.781C910@the-rileys.net>
Date: Wed, 31 Jan 2001 14:58:54 -0500
From: David Riley <oscar@the-rileys.net>
Organization: The Riley Family
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
In-Reply-To: <Pine.LNX.4.10.10101310752060.155-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
> 
> >>From what I gather this chipset on 2.4.x is only stable if you cripple just about everything that makes
> > it worth having (udma, 2nd ide channel  etc etc)  ?    does it even work when all that's done now or is
> > it fully functional?
> 
> it seems to be fully functional for some or most people,
> with two, apparently, reporting major problems.
> 
> my via (kt133) is flawless in 2.4.1 (a drive on each channel,
> udma enabled and in use) and has for all the 2.3's since I got it.

Not to make a "mee too" post but...

It's worked flawlessly for me.  Always.  Since it seems to work fine for
just about everyone else, I'd venture to say that it's a board specific
issue, quite likely with the BIOS.  Some other problems seem to have to
do with the memory; I remember the KX133 had some definite problems with
memory timing, especially with large amounts (3 DIMMS were a problem on
some motherboards that were loosely laid out).

My 2 cents,
	David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
