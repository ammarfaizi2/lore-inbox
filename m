Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318614AbSHAFFZ>; Thu, 1 Aug 2002 01:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318627AbSHAFFZ>; Thu, 1 Aug 2002 01:05:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61962 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318614AbSHAFFY>; Thu, 1 Aug 2002 01:05:24 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [2.6] The List, pass #2
Date: Thu, 1 Aug 2002 05:08:41 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aiafop$fci$1@penguin.transmeta.com>
References: <3D3761A9.23960.8EB1A2@localhost> <200208010156.g711uMc340112@saturn.cs.uml.edu>
X-Trace: palladium.transmeta.com 1028178513 12279 127.0.0.1 (1 Aug 2002 05:08:33 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 1 Aug 2002 05:08:33 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200208010156.g711uMc340112@saturn.cs.uml.edu>,
Albert D. Cahalan <acahalan@cs.uml.edu> wrote:
>Guillaume Boissier writes:
>
>> Definitely 2.7:
>>
>> o InfiniBand support
>
>Why?

It's big, it's complex, and nobody seems to take it that seriously (the
only people who ever asked _me_ about it was Intel, and they seem to
have cancelled their own projects). 

If it turns out to be a big hit, it can be backported. But as it looks
now, it has very little relevance for any 2.6 freeze schedule.

		Linus
