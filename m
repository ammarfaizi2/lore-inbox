Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132901AbRA2TVv>; Mon, 29 Jan 2001 14:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132952AbRA2TVl>; Mon, 29 Jan 2001 14:21:41 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:30472 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132901AbRA2TVW>; Mon, 29 Jan 2001 14:21:22 -0500
Message-ID: <3A75C2A0.6C21F517@transmeta.com>
Date: Mon, 29 Jan 2001 11:21:04 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <200101281012.LAA04278@cave.bitwizard.nl> <3A73F1EB.B6F69A93@transmeta.com> <20010128233425.E1300@bug.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>> >
> > And you're still overwriting the POST value written by the BIOS.
> 
> So save value from bios at initial boot ;-).
>                                                                 Pavel

Write-only register.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
