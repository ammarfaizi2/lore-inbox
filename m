Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291306AbSCRSZL>; Mon, 18 Mar 2002 13:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291372AbSCRSZC>; Mon, 18 Mar 2002 13:25:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14099 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291306AbSCRSY4>; Mon, 18 Mar 2002 13:24:56 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help
Date: 18 Mar 2002 10:24:38 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a75bd6$mb5$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33L2.0203180809120.2434-100000@dragon.pdx.osdl.net> <Pine.LNX.3.95.1020318112042.740A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.95.1020318112042.740A-100000@chaos.analogic.com>
By author:    "Richard B. Johnson" <root@chaos.analogic.com>
In newsgroup: linux.dev.kernel
> 
> Is it a standard or is it something in-process? The reason I ask is
> that neither KB nor KiB can possibly be correct.
> 
> According to the standards, where capitalization is used:
> 	(1) For a proper name.
> 	(2) To differentiate between otherwise identical symbols.
> 

This is obviously untrue for prefixes.  Consider the prefix T (10^12),
which has no lower-case equivalent.

The unit here is B, which does conflict with the unit bel, but is
widely used to mean byte in computer contexts.

I don't like the pronunciations used in the new standard, but I think
using Ki, Mi, Gi, ... at least in writing is a good thing, to
disambiguate between binary and decimal powers.  I just read them as
"binary kilobytes" etc if I need to be clear.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
