Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278491AbRJPB6R>; Mon, 15 Oct 2001 21:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278492AbRJPB6H>; Mon, 15 Oct 2001 21:58:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43282 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278491AbRJPB5r>; Mon, 15 Oct 2001 21:57:47 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: VM
Date: Tue, 16 Oct 2001 01:57:41 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9qg46l$378$1@penguin.transmeta.com>
In-Reply-To: <20011015211216.A1314@localhost>
X-Trace: palladium.transmeta.com 1003197486 3409 127.0.0.1 (16 Oct 2001 01:58:06 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 16 Oct 2001 01:58:06 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011015211216.A1314@localhost>,
Patrick McFarland  <unknown@panax.com> wrote:
>
>Why is the simple vm system still in place on the linus tree? I would
think the smart vm system in the ac tree would be better suited to .. 
oh..  say ..  everything.

"complex" != "smart".

The benchmarks I've seen says that the simple VM performs better - both
in terms of repeatability and in terms of absolute performance. Search
this list yourself if you don't believe me.

		Linus
