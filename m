Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289822AbSAKBqr>; Thu, 10 Jan 2002 20:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289825AbSAKBqh>; Thu, 10 Jan 2002 20:46:37 -0500
Received: from svr3.applink.net ([206.50.88.3]:14342 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S289822AbSAKBqW>;
	Thu, 10 Jan 2002 20:46:22 -0500
Message-Id: <200201110146.g0B1jrSr032628@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: "Martin Eriksson" <nitrax@giron.wox.org>,
        "Ronald Wahl" <Ronald.Wahl@informatik.tu-chemnitz.de>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
Date: Thu, 10 Jan 2002 19:42:06 -0600
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E16Opxl-00066O-00@the-village.bc.nu> <015701c19a3c$8f2b7630$0201a8c0@HOMER>
In-Reply-To: <015701c19a3c$8f2b7630$0201a8c0@HOMER>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 January 2002 19:09, Martin Eriksson wrote:
> ----- Original Message -----
> From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
> To: "Ronald Wahl" <Ronald.Wahl@informatik.tu-chemnitz.de>
> Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>; <linux-kernel@vger.kernel.org>
> Sent: Friday, January 11, 2002 1:54 AM
> Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
>
>
> <snip>
>
> > It can be easily caught. Thats what rpm is for. If it let you install
> > that package on a box that can run it without using --force type options
> > its a bug.
>
> Just curious; is RPM a "standard" for most linux distros now? I have always
> been running RedHat so I wouldn't know.

IIRC, it is a standard according to the FHS.   Please let's not get started 
on the RPM v. Apt debate.

>
> Maybe Ronald should start a new kernel tree with patches for goofy admins
> ;D

You know, it's funny how people think.  I'm sure that  we all have had some 
ideas which appear goofy to others, esp. at first blush.   I think that 
creativity requires that thoughts sometimes be juxtaposed in a goofy manner;
usually it  creates garbage, but sometimes it's like peanut butter and 
chocolate. :-)

That much said, a good system administrator should be able to handle this
situation without having to rely on RPM.   The fact that that RedHat ships 
everything defaulted to i386 (except the kernel) is just one more proof of 
good thinking.  If you know what you're doing, then Mandrake i586 is good, 
but can be a rude awakening for newbies, which is Mandrake's target it
would seem.

IMHO, for ordinary day to day tasks, the gains from compiling -m[4|5|6] are
not worth the effort and extra administrative work.


-- 
timothy.covell@ashavan.org.
