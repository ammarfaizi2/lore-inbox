Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272721AbRIPTjx>; Sun, 16 Sep 2001 15:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272723AbRIPTjf>; Sun, 16 Sep 2001 15:39:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43525 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272730AbRIPTjZ>; Sun, 16 Sep 2001 15:39:25 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: broken VM in 2.4.10-pre9
Date: Sun, 16 Sep 2001 19:38:45 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9o2v45$87o$1@penguin.transmeta.com>
In-Reply-To: <20010916094759.A14053@peach.zawodny.com> <E15igmC-0005bs-00@the-village.bc.nu>
X-Trace: palladium.transmeta.com 1000669174 4721 127.0.0.1 (16 Sep 2001 19:39:34 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 16 Sep 2001 19:39:34 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E15igmC-0005bs-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>> Yep, that was me.  It was frustrating to have to double the RAM in the
>> machine and then turn off swap.  The extra RAM did help, but it really
>> only delayed the problem.
>
>That shouldnt be needed with at least the later -ac kernels - nor is the
>swap > twice ram rule present in those

Nor has it been present in the standard kernels since 2.4.8.

		Linus
