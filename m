Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137160AbREKPmt>; Fri, 11 May 2001 11:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137159AbREKPma>; Fri, 11 May 2001 11:42:30 -0400
Received: from idiom.com ([216.240.32.1]:6413 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S137158AbREKPm2>;
	Fri, 11 May 2001 11:42:28 -0400
Message-ID: <3AFBA5E8.C698627@namesys.com>
Date: Fri, 11 May 2001 01:42:16 -0700
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14cl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tony Hoyle <tmh@magenta-netlogic.com>
CC: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <01050910381407.26653@bugs> <20010510134453.A6816@emma1.emma.line.org> <3AFA9AD8.7080203@magenta-netlogic.com> <20010511013726.C31966@emma1.emma.line.org> <3AFBFDB0.5080904@magenta-netlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Hoyle wrote:

> Matthias Andree wrote:
>
> > You're not getting data loss, but access denied, when hitting
> > incompatibilities, and it looks like it hits 2.2 hard while 2.4 is less
> > of a problem. Please search the reiserfs list archives for details.
> > vs-13048 is a good search term, I believe.
>
> Data is lost:
>
> Root can't access the files.
> Reiserfsck can't repair the files.
> The files that are corrupted are unrelated to the ones exported over NFS
> (which makes me wonder if it's the same bug).
>
> File corruption would begin a couple of hours after the volume was
> formatted, and become catastrophic within a couple of days.
>
> Until the fix is merged I'm not going within 100 miles of reiserfs!
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

there is a patch, it is on our website, what is the problem?

