Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271361AbRHOTNg>; Wed, 15 Aug 2001 15:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271367AbRHOTNZ>; Wed, 15 Aug 2001 15:13:25 -0400
Received: from mail1.panix.com ([166.84.0.212]:8182 "HELO mail1.panix.com")
	by vger.kernel.org with SMTP id <S271361AbRHOTNJ>;
	Wed, 15 Aug 2001 15:13:09 -0400
From: "Roy Murphy" <murphy@panix.com>
Reply-To: murphy@panix.com
To: linux-kernel@vger.kernel.org
Date: Wed, 15 Aug 2001 15:13:23 -0500
Subject: Re: Are we going too fast?
X-Mailer: DMailWeb Web to Mail Gateway 2.6k, http://netwinsite.com/top_mail.htm
Message-id: <3b7ac9d3.69c4.0@panix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'Twas brillig when Mike Edwards scrobe:
>I think that's a bit unfair. Rather, I suspect people see the 
>word 'stable', and assume, for some unknown reason, that the kernel is >stable.
*AHEM* 

Whatever truth value 2.4 has for the variable stable, it can not be stored in
a boolean type.

'Stable' means that the direction of development is intended to reduce the number
of bugs not add new features unless they can reasonably be shown to not introduce
major bugs.  That the 2.5 tree has not been opened indicates the recognition
that additional concentrated work on 2.4 is needed.

>Seriously, though - even distributions are including 2.4 kernels now. 
>RedHat, Mandrake, Slackware ... Should the latest versions of these 
>distributions be considered unstable as well? 

Even older releases of distributions are maintained.  Should we ever get to
kernel 2.2.38, the distribution maintainers should be releasing bugfix patches
for older distributions with the latest 2.2 kernel.

>Perhaps it needs to be made clear to people that these kernels still 
>aren't all they could be. 

No kernel is perfect.  The judgement was that it was ready to switch from adding
features to increasing stability.  Thus it has ever been since my first kernel
~= 0.95.
-- 
Roy Murphy      \ CSpice -- A mailing list for Clergy Spouses
murphy@panix.com \  http://www.panix.com/~murphy/CSpice.html
