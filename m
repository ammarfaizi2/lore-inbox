Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268182AbRGWKuU>; Mon, 23 Jul 2001 06:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268183AbRGWKuK>; Mon, 23 Jul 2001 06:50:10 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:26117 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268182AbRGWKt6>; Mon, 23 Jul 2001 06:49:58 -0400
Message-ID: <3B5C0049.31DE2ED9@namesys.com>
Date: Mon, 23 Jul 2001 14:45:29 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: Ian Chilton <ian@ichilton.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: OT: Journaling FS Comparison
In-Reply-To: <Pine.LNX.4.21.0107231004080.612-100000@penguin.homenet>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Tigran Aivazian wrote:
> 
> On Sun, 22 Jul 2001, Ian Chilton wrote:
> > With there been 4 of them (ext3, reiserfs, XFS and JFS),
> > it's not an easy choice for anyone.
> 
> at the time when I did the comparison using SPEC SFS to benchmark, the
> choice was not hard at all -- absolute and obvious winner was reiserfs.
> That is, amongst the freely available ones. (this was not too long ago, a
> mere 2 months or so).
> 
> However, if you are willing to pay for your filesystem, our vxfs beats all
> of the above at _very_ (very) high loads (loads unreachable by any other
> filesystem so far ;) in both performance and stability. (well, it beats
> them in most situations at low loads as well but that is not interesting)
> 
> It should be available to our beta-customers via www.veritas.com
> somewhere...
> 
> Regards,
> Tigran
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

SPEC SFS is a proprietary and expensive benchmark which precludes us from optimizing for it, which
is a pity, I suspect we'd learn something from analyzing its results.

How much does vxfs cost these days?

Hans
