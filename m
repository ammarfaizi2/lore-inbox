Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282491AbRLAXdj>; Sat, 1 Dec 2001 18:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281732AbRLAXda>; Sat, 1 Dec 2001 18:33:30 -0500
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:38910 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S282487AbRLAXdP>; Sat, 1 Dec 2001 18:33:15 -0500
Date: Sat, 1 Dec 2001 15:32:28 -0800 (PST)
From: Gideon Glass <gid@cisco.com>
To: Richard Russon <ldm@flatcap.org>
cc: "Eric S. Raymond" <esr@snark.thyrsus.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: esr cut off my genitives
In-Reply-To: <1007229787.2134.10.camel@addlestones>
Message-ID: <Pine.GSO.4.33.0112011515550.23029-100000@andorra.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 1 Dec 2001, Richard Russon wrote:

> Hi esr,
>
> There are a couple of lines of the patch I'm not quite happy with.
>
> > -Windows' Logical Disk Manager (Dynamic Disk) support (EXPERIMENTAL)
> > +Windows Logical Disk Manager (Dynamic Disk) support (EXPERIMENTAL)
>
> > -Windows' LDM extra logging
> > +Windows LDM extra logging
>
> Not wishing to sound too pedantic, but I did put the apostropes in on
> purpose.  "Windows" is a plural noun and the genitive of it is "Windows'".

If you really want to get pedantic..

"windows" is a plural noun, but "Windows" is a singular proper noun, and
in "Windows LDM" it functions as an adjective.  Using possessive here is
confusing because it suggests that this feature belongs to Windows, or
that it's part of Windows itself, but obviously it isn't (the feature
being referred to is part of Linux).  It is only *related* to Windows, so
the adjectival "Windows" is the best thing to use.

>
> Of course if it's a limitation of the new config tool I'll understand :-)
> (and you'll need to apply the following, too).
>
> -IBM's S/390 architecture
> +IBMs S/390 architecture

The "IBMs" plural construction is wrong since there is only one IBM.
"IBMs" can't be possessive because there is no reason not to use an
apostrophe to indicate possessive in this case.  Note that "IBM S/390
architecture" could be used, with "IBM" (a noun) functioning as an
adjective in the same manner as "Windows" above.  However, expressing the
notion of ownership/control ("IBM's") conveys more information then mere
association ("IBM"), so "IBM's" seems preferable here.

gid


>
> Cheers,
>   FlatCap (Rich)
>   ldm@flatcap.org
>
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

