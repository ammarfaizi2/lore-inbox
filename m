Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130902AbQJ1GDf>; Sat, 28 Oct 2000 02:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130913AbQJ1GDZ>; Sat, 28 Oct 2000 02:03:25 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:19207 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130902AbQJ1GDL>; Sat, 28 Oct 2000 02:03:11 -0400
Message-ID: <39FA6BFF.17AFBFF0@transmeta.com>
Date: Fri, 27 Oct 2000 23:02:39 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: barryn@pobox.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: IA-32 (was Re: [PATCH] cpu detection fixes for test10-pre4)
In-Reply-To: <200010280432.VAA01337@cx518206-b.irvn1.occa.home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Barry K. Nathan" wrote:
> 
> H. Peter Anvin wrote:
> 
> > Alan Cox wrote:
> 
> [snip]
> 
> > > ia32 is an intel trademark. Using it for non intel products is probably an
> > > actionable matter ..
> > >
> >
> > Yet another reason to ignore it.
> 
> Speaking of using it for non-Intel products, this is a line from
> Documentation/Changes in Linux 2.4.0-test10-pre6:
> 
> Linux on IA-32 has recently switched from using as86 to using gas for
> 
> Should we change that to x86 or something?
> 

Since Linux generally calls this i386 throughout, I would stick with
calling it i386.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
