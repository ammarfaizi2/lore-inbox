Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130453AbQLBVpX>; Sat, 2 Dec 2000 16:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130498AbQLBVpM>; Sat, 2 Dec 2000 16:45:12 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:45572 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130453AbQLBVpG>; Sat, 2 Dec 2000 16:45:06 -0500
Message-ID: <3A296529.545192C2@transmeta.com>
Date: Sat, 02 Dec 2000 13:10:01 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch-2.4.0-test12-pre3] microcode update for P4 (fwd)
In-Reply-To: <Pine.LNX.4.21.0012022103290.933-100000@penguin.homenet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> 
> On Sat, 2 Dec 2000, H. Peter Anvin wrote:
> >
> > OK, fair enough.  Let me make a new statement then: I suggest we preface
> > these with MSR_ anyway so we can tell what they really are.
> >
> 
> That is much better. Actually, I accept your suggestion. (because I have
> just found a few more cleanups to be done in the code but they were not
> worth a patch on their own but together with the above it is worth
> remaking the patch).
> 
> So, unless Linus already applied it I will resend a new one to him
> shortly.
> 
> Regards,
> Tigran
> 
> PS. Btw, the proof of my statement is found at:
> 
> http://developer.intel.com/design/pentium4/manuals/245472.htm
> 
> and download the PDF, then read the section 8.11.1 on page 8-32.

I believe you :)  Pardon me now, I have a foot to get unstuck from this
here mouth of mine...

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
