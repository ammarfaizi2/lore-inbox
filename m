Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311900AbSDBQDU>; Tue, 2 Apr 2002 11:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312824AbSDBQDA>; Tue, 2 Apr 2002 11:03:00 -0500
Received: from Expansa.sns.it ([192.167.206.189]:55558 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S311900AbSDBQC4>;
	Tue, 2 Apr 2002 11:02:56 -0500
Date: Tue, 2 Apr 2002 18:02:54 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Ken Brownfield <ken@irridia.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Status of quotas on ext3 and reiser?
In-Reply-To: <20020401211410.A9161@asooo.flowerfire.com>
Message-ID: <Pine.LNX.4.44.0204021801490.17853-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am using quota with reiserFS and quota tool 3.04 from slackware-current,
and no problems at all (kernel 2.4.18)


On Mon, 1 Apr 2002, Ken Brownfield wrote:

> I'm about to install a 2TB disk array, and I'd very strongly prefer to
> use ext3 or possibly reiser to gain journaling.  Fscking 250GB is
> already lethal.
>
> But I also need quotas.  I've noticed that quotas do not appear to be
> supported by ext3, but I haven't tried reiser yet.  And I'm not sure
> if I simply need new quota userspace tools -- the ones I found were 1994
> vintage.  I'm on RH6.2 BTW for this case, and the builtin tools don't
> appear to grok ext3.
>
> What is the current viability of quotas on ext3/reiser in a
> conservative, production environment?  Is it waiting for the 32-bit UID
> mods in 2.4.x, or has quota support been pushed off onto 2.5?  Am I
> going to have to make the hard choice of journaling vs quotas? :-/
>
> I couldn't find a definitive answer in the archives; sorry if this is a
> FAQ.  I'd bug poor Andrew Morton directly :), but I'm also interested in
> the status or reiser vs quotas.
>
> Thanks,
> --
> Ken.
> ken@irridia.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

