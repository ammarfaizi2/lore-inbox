Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137170AbREKQnU>; Fri, 11 May 2001 12:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137171AbREKQnK>; Fri, 11 May 2001 12:43:10 -0400
Received: from idiom.com ([216.240.32.1]:56074 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S137170AbREKQmt>;
	Fri, 11 May 2001 12:42:49 -0400
Message-ID: <3AFBB40D.6A52A7D8@namesys.com>
Date: Fri, 11 May 2001 02:42:37 -0700
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14cl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: hps@intermeta.de
CC: linux-kernel@vger.kernel.org, nikita@namesys.com
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <20010511013913.D31966@emma1.emma.line.org> <172380000.989592181@tiny> <9dgvvn$n3h$1@forge.intermeta.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Henning P. Schmiedehausen" wrote:

> Chris Mason <mason@suse.com> writes:
>
> >It requires explicit changes to each filesystem that wants to work over
> >NFS, and is a somewhat large change.
>
> Come on, we got zerocopy TCP pushed into a stable kernel release with
> the words "get over it".
>
> So please, push this patch to Linus; I really like to "get over it".
>
> I think with the growing acceptance of ReiserFS in the Linux
> community, it is tiresome to have to apply a patch again and again
> just to get working NFS. 2.2 NFS horrors all over again.
>
>         Regards
>                 Henning
> --
> Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
> INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de
>
> Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
> D-91054 Buckenhof     Fax.: 09131 / 50654-20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

nikita, ask Neil what the timeline is for it going into Linux.

Hans

