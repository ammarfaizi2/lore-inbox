Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132176AbRBDSHe>; Sun, 4 Feb 2001 13:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132210AbRBDSHY>; Sun, 4 Feb 2001 13:07:24 -0500
Received: from [206.191.149.217] ([206.191.149.217]:59631 "EHLO
	ursa.seattlefirewall.dyndns.org") by vger.kernel.org with ESMTP
	id <S132208AbRBDSHQ>; Sun, 4 Feb 2001 13:07:16 -0500
Date: Sun, 4 Feb 2001 10:07:09 -0800 (PST)
From: Tom Eastep <teastep@seattlefirewall.dyndns.org>
To: Hacksaw <hacksaw@hacksaw.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Major Clock Drift 
In-Reply-To: <200102041804.f14I4br22433@habitrail.home.fools-errant.com>
Message-ID: <Pine.LNX.4.30.0102041005460.857-100000@wookie.seattlefirewall.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spoke Hacksaw:

> >I've discovered that heavy use of vesafb can be a major source of clock
> >drift on my system, especially if I don't specify "ypan" or "ywrap". On my
>
> This is extremely interesting. What version of ntp are you using?
>

The RH7 rpm -- ntp-4.0.99k-5

-Tom
-- 
Tom Eastep             \ Alt Email: tom@seattlefirewall.dyndns.org
ICQ #60745924           \ Websites: http://seawall.sourceforge.net
teastep@evergo.net       \          http://seattlefirewall.dyndns.org
Shoreline, Washington USA \___________________________________________

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
