Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316670AbSERF0b>; Sat, 18 May 2002 01:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316744AbSERF0a>; Sat, 18 May 2002 01:26:30 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:52728 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S316670AbSERF0a>; Sat, 18 May 2002 01:26:30 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Wayne.Brown@altec.com
Cc: linux-kernel@vger.kernel.org
Date: Fri, 17 May 2002 22:23:10 -0700 (PDT)
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
In-Reply-To: <86256BBD.001C64E2.00@smtpnotes.altec.com>
Message-ID: <Pine.LNX.4.44.0205172220400.32688-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne, the only change (other then better, faster functions) is the
elimination of steps.

if it will satisfy you you can continue to do a make mproper and make dep
and just ignore the 'no target found' messages.

David Lang

On Sat, 18 May 2002 Wayne.Brown@altec.com wrote:

> Date: Sat, 18 May 2002 00:09:19 -0500
> From: Wayne.Brown@altec.com
> To: linux-kernel@vger.kernel.org
> Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
>
>
>
> Gee, what a tolerant attitude.  I state my preference -- not a demand, just a
> preference -- that the old interfaces be retained IN ADDITION to whatever new
> features are added, and you say "Bah go away."  I'm sorry, I must have missed
> the rule that says only people who agree with you are allowed to post their
> opinions on lkml.
>
> The current system works just fine for my needs.  I've never seen the point of
> trying to "improve" things that are already good enough.  But now that you've
> explained it to me so politely, I understand.  My top priority is supposed to be
> what YOU want, even though you don't care anything at all about what I want.
>
> So, in the spirit of your oh-so-helpful message, let me say this:  Get stuffed,
> jerk.
>
>
>
>
>
> Robert Love <rml@tech9.net> on 05/17/2002 06:14:45 PM
>
> To:   Wayne Brown/Corporate/Altec@Altec
> cc:   linux-kernel@vger.kernel.org
>
> Subject:  Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
>
>
>
>
> So we should curb progress in the name of you not spending 2 minutes
> rewriting your bash scripts or repopulating your bash history with new
> commands?
>
> Bah go away.  I and most other people here are the exact opposite - give
> us new features, less bugs, or innovation and we will surely change.
> Otherwise we would still be in the stone age.
>
>      Robert Love
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
