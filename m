Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSEQTyl>; Fri, 17 May 2002 15:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316674AbSEQTyk>; Fri, 17 May 2002 15:54:40 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:60687 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S316673AbSEQTyh>; Fri, 17 May 2002 15:54:37 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: linux-kernel@vger.kernel.org
Message-ID: <86256BBC.006D500D.00@smtpnotes.altec.com>
Date: Fri, 17 May 2002 14:51:57 -0500
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Constructive comments would be appropriate if I wanted to help construct a new
kbuild.  The truth is that I'm quite happy with the current kbuild and don't
want it replaced with *anything* at all.  (That's the same reason I'm glad no
one's been talking about CML2 lately.)  The new one wouldn't bother me if the
user interface were *exactly* identical to the old one; i.e., if I could keep
typing exactly the same commands to build a kernel and get exactly the same
results and not be able to tell that anything had changed in the build process.

Personally, I wish that the only changes anybody made were to the kernel itself
(new drivers added, existing performance improved, etc.) and that all the
supporting tools and utilities just could be left alone.  I know that's not
going to happen, but anything that slows down changes in those extraneous things
is fine with me.  I'd be perfectly happy if *years* from now I was compiling
Linux 45.10.12 with the same kbuild, CML, gcc and everything else that I'm using
right now.





Adam Kropelin <akropel1@rochester.rr.com> on 05/17/2002 12:37:18 PM

To:   linux-kernel@vger.kernel.org
cc:    (bcc: Wayne Brown/Corporate/Altec)

Subject:  Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3



On Fri, May 17, 2002 at 09:21:12AM -0500, Wayne.Brown@altec.com wrote:
>
>
> OTOH, those of us who are not looking forward to kbuild 2.5 are grateful for
any
> delays we can get.

...and what would your beefs (beeves?) with kbuild-2.5 be? I searched the
archives
for the last 12 months and I don't see anythinng from you relevant to
kbuild-2.5.
Keith has been addressing concerns quite regularly; I should think if you have
constructive comments, he'd surely listen.

You *do* have constructive comments, right?

--Adam
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




