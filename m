Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSFNUYw>; Fri, 14 Jun 2002 16:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314227AbSFNUYv>; Fri, 14 Jun 2002 16:24:51 -0400
Received: from mtvwca1-smrly1.gtei.net ([128.11.176.196]:58828 "HELO
	mtvwca1-smrly1.gtei.net") by vger.kernel.org with SMTP
	id <S314096AbSFNUYu>; Fri, 14 Jun 2002 16:24:50 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Arkeia Back + v2.4.18
In-Reply-To: <m38z5jvz2f.fsf@noop.bombay> <20020614144554.GA7428@lech.pse.pl>
From: Nick Papadonis <nick@coelacanth.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Date: Fri, 14 Jun 2002 16:24:48 -0400
Message-Id: <m3hek5fw1b.fsf@noop.bombay>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.1 (Cuyahoga Valley,
 i686-pc-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lech Szychowski <lech.szychowski@pse.pl> writes:

>> Is anyone having kernel lock ups using 'Arkeia backup' with kernel
>> v2.4.18?
>
> As a client? No, it runs without any problems here (various 2.4.1[89]-*).
> As a server? No, it runs without any problems here (2.4.18-pre3-ac2).

Thanks for the reply.

Interesting.  

Are you using the 'free' version?  
What type of SCSI controller and SCSI tape drive do you have?

My problem could be in the AIC7XXXX driver using my 29160 card.

- Nick
