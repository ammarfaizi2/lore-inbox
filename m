Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267982AbRG2No6>; Sun, 29 Jul 2001 09:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267976AbRG2Nos>; Sun, 29 Jul 2001 09:44:48 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:43530 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267982AbRG2Nog>; Sun, 29 Jul 2001 09:44:36 -0400
Message-ID: <3B6412CB.8950A548@namesys.com>
Date: Sun, 29 Jul 2001 17:42:35 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
CC: Andre Pang <ozone@algorithm.com.au>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <20010726174844.W17244@emma1.emma.line.org> <E15PnTJ-0003z0-00@the-village.bc.nu> <9jpftj$356$1@penguin.transmeta.com> <20010726095452.L27780@work.bitmover.com> <996167751.209473.2263.nullmailer@bozar.algorithm.com.au> <3B605A3B.6E95AE36@namesys.com> <20010729004542.A9350@emma1.emma.line.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Matthias Andree wrote:
> 
> On Thu, 26 Jul 2001, Hans Reiser wrote:
> 
> > No, Linus is right and the MTA guys are just wrong.  The mailers are
> > the place to fix things, not the kernel.  If the mailer guys want to
> > depend on the kernel being stupidly designed, tough.  Someone should
> > fix their mailer code and then it would run faster on Linux than on
> > any other platform.
> 
> Well, some systems are even documented that way, so there's nothing with
> "depend on the kernel being stupidly designed", but "depend on what
> mount(8) says".
> 
> MTA authors don't play games, they also write that their software relies
> on this behaviour, as laid out.
> 
> --
> Matthias Andree
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
Documenting their code won't make it fast or well designed.

Hans
