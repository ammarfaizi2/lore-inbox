Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbRA3JeO>; Tue, 30 Jan 2001 04:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129789AbRA3JeE>; Tue, 30 Jan 2001 04:34:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:57348 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129704AbRA3Jds>; Tue, 30 Jan 2001 04:33:48 -0500
Message-ID: <3A768A6B.78D72693@transmeta.com>
Date: Tue, 30 Jan 2001 01:33:31 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Michael B. Trausch" <fd0man@crosswinds.net>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail can't deal with ECN
In-Reply-To: <Pine.LNX.4.21.0101300350290.2225-100000@fd0man.accesstoledo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael B. Trausch" wrote:
> 
> On 29 Jan 2001, H. Peter Anvin wrote:
> >
> > He's keeping in mind who owns Hotmail.  However, I think that's unfair
> > to the Hotmail guys; all the ones I have ever spoken with have been
> > very professional and genuinely concerned with standards compliance.
> >
> 
> I would also keep in mind, that Microsoft doesn't even run their *own*
> system on Hotmail.  Currently they're using Solaris, and from what I hear
> they might be moving Linux in there fairly soon.
> 

I don't know if that's true.  The headers I've seen from hotmail users --
and Netcraft seem to agree -- indicate that they have migrated over to
Win2K.  I do understand this was a forced migration for non-technical
reasons, and that they had quite a bit of problems.

An interesting exception seem to be the hosts named ad.law*.hotmail.com,
which Netcraft claim to be FreeBSD.

	-hp

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
