Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282011AbRKZSeO>; Mon, 26 Nov 2001 13:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282019AbRKZScx>; Mon, 26 Nov 2001 13:32:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58631 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282016AbRKZScQ>; Mon, 26 Nov 2001 13:32:16 -0500
Message-ID: <3C028A8D.8040503@zytor.com>
Date: Mon, 26 Nov 2001 10:31:41 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Release Policy [was: Linux 2.4.16  ]
In-Reply-To: <Pine.LNX.4.40.0111261216500.88-100000@rc.priv.hereintown.net> <Pine.LNX.4.21.0111261351160.13786-100000@freak.distro.conectiva> <9tu0n2$sav$1@cesium.transmeta.com> <20011126192902.M5770@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:

>>
>>Oh, and yes, if you settle on a naming scheme, *please* let me know
>>ahead of time so I can update the scripts to track it, rather than
>>finding out by having hundreds of complaints in my mailbox...
>>
> 
> I for one used the -pre and -pre-final naming for the v2.0.39-series,
> and I'll probably use the same naming for the final pre-patch of
> v2.0.40, _unless_ there's some sort of agreement on another naming 
> scheme. I'd be perfectly content with using the -rc naming for the
> final instead. The important thing is not the naming itself, but
> consistency between the different kernel-trees.
> 


Consistency is a Very Good Thing[TM] (says the one who tries to teach
scripts to understand the naming.)  The advantage with the -rc naming is
that it avoids the -pre5, -pre6, -pre-final, -pre-final-really,
-pre-final-really-i-mean-it-this-time phenomenon when the release
candidate wasn't quite worthy, you just go -rc1, -rc2, -rc3.  There is no
shame in needing more than one release candidate.

	-hpa


