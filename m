Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271304AbRHZLxN>; Sun, 26 Aug 2001 07:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271306AbRHZLwy>; Sun, 26 Aug 2001 07:52:54 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:26896 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S271304AbRHZLwp>; Sun, 26 Aug 2001 07:52:45 -0400
Message-ID: <3B88E06A.85235122@namesys.com>
Date: Sun, 26 Aug 2001 15:41:30 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Samium Gromoff <_deepfire@mail.ru>
CC: linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: [OT] Howl of soul...
In-Reply-To: <E15aK0R-000M5f-00@f8.mail.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samium Gromoff wrote:
> 
>      dear people!
> 
>    Sorry for OT, but i want only good to you, lkml
>  people...
>    If you are to buy a new ide drive, do not buy
>  recent IBM 7200 drives!!!
>    The story begins when at February of this year i`ve bought
>  perfectly shining ever-fast IBM DTLA-307045...
>    After 3 months i`ve hardly regreted about such
>  decision: drive started to covers himself with a thick
>  layer of logical-not-physical badblocks (ie lowlevel
>  reformat doesnt show anything).
>    So i went to storagereview and lerned about the matter.
>  As i found, these drives had an internal controller bug.
> 
>    So i said okay, while restoring 3rd time my reiserfs
>  and dumping data to spare drive, and went to
>  replace the drive to perfectly new and shining
>  IBM IC35L040AVER07-0 also known as 60GXP.
> 
>    Now i`am heavily punished for that.
>  Badblocks are reapperaing on runtime.
>    After they appeared first time i`ve attached large
>  fan to the drive, so it was cold(!) to touch. Also
>  i stopped to transport the drive between boxes.
> 
>    Nevertheless these fscking logical badblocks
>  appeared again twice.
> 
>    The fact is, that we had bought these drives
>  with my friend synchronusly, and now he owns
>  quantum drive, after 75gxp and 60gxp...
>    Ofcourse he had similar problems.... (btw he use windoze)
> 
>    I am _tired_ fixing my poor reiserfs root partition.
>    I can say that now i`am expert on how to restore
>  badblocked reiserfs partiotions... ;(
> 
>    Beware.
> 
> ---
> 
> cheers,
> 
>    Samium Gromoff
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


I am confused, you and your friend both had problems, and you used IBM and he
used quantum?  Do they have similar electronics?

Take a look at www.namesys.com, there is a badblocks patch, god@namesys.com will
tell you details about it.

hans
