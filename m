Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136700AbREJOqH>; Thu, 10 May 2001 10:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136701AbREJOp5>; Thu, 10 May 2001 10:45:57 -0400
Received: from idiom.com ([216.240.32.1]:40204 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S136700AbREJOpt>;
	Thu, 10 May 2001 10:45:49 -0400
Message-ID: <3AFAA98A.F79471CF@namesys.com>
Date: Thu, 10 May 2001 07:45:31 -0700
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14cl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tony Hoyle <tmh@magenta-netlogic.com>
CC: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <01050910381407.26653@bugs> <20010510134453.A6816@emma1.emma.line.org> <3AFA9AD8.7080203@magenta-netlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Hoyle wrote:

> Matthias Andree wrote:
>
> > ext3fs has never given me any problems, but I did not have it in
> > production use where I discovered major ReiserFS <-> kNFSd
> > incompatibilities. ext3 has a 0.0.x version number which suggests it's
> > not meant for production use.
>
> Hmm... Reiserfs is incompatible with knfsd?  That might explain the
> massive data loss I was getting with reiserfs (basically I'd have to
> reformat and reinstall every couple of weeks).  The machine this was
> happening with also exports my apt cache for the rest of the network.
>
> Tony
>
> --
> Where a calculator on the ENIAC is equpped with 18,000 vaccuum
> tubes and weighs 30 tons, computers in the future may have only
> 1,000 vaccuum tubes and perhaps weigh 1 1\2 tons.
> -- Popular Mechanics, March 1949
>
> tmh@magenta-netlogic.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

we have a patch on our website.

Hans

