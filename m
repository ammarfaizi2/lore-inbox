Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130340AbRBARjo>; Thu, 1 Feb 2001 12:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130587AbRBARjf>; Thu, 1 Feb 2001 12:39:35 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:51466 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130641AbRBARjT>; Thu, 1 Feb 2001 12:39:19 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Need for more ISO8859 codepages?
Date: 1 Feb 2001 09:39:05 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <95c6vp$n7t$1@cesium.transmeta.com>
In-Reply-To: <4755.137.44.4.15.981028098.squirrel@www.sucs.swan.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <4755.137.44.4.15.981028098.squirrel@www.sucs.swan.ac.uk>
By author:    "Rhys Jones" <linux-kernel@postwales.com>
In newsgroup: linux.dev.kernel
>
> Hello,
> 
> Please forgive a semi-newbie post.
> 
> About 18 months ago I patched fs/nls/ to include support for the
> Celtic character set, ISO8859-14. I notice that there are still gaps
> in nls, specifically in ISO8859 codepages 10 to 13.
> 
> The missing codepages are for Nordic/Icelandic (ISO8859-10), Thai
> (ISO8859-11), and Baltic Rim (ISO8859-13) languages. I'm still trying
> to determine the status of ISO8859-12 at the moment.
> 
> Two questions, really. The general one is whether anyone would find
> these codepages useful. If they would, I'm willing to provide the
> patches in due course. More specifically, can anyone tell me why
> ISO8859-10 (Icelandic etc.) is mentioned in Documentation/Configure.help
> whilst nls_iso8859-10.c is missing from the fs/nls directory?
> 

Having them around can never be a bad thing.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
