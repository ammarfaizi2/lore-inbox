Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283027AbRK1ND3>; Wed, 28 Nov 2001 08:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283031AbRK1NDT>; Wed, 28 Nov 2001 08:03:19 -0500
Received: from maila.telia.com ([194.22.194.231]:17625 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S283027AbRK1NDL>;
	Wed, 28 Nov 2001 08:03:11 -0500
Message-ID: <3C04DF32.50902@peope.net>
Date: Wed, 28 Nov 2001 13:57:22 +0100
From: Per-Olof Pettersson <lkml.lists@peope.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.5) Gecko/20011011
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Release Policy [was: Linux 2.4.16 ]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell wrote:

> Why not just disguard this sillyness of alphabetic characters in version
> numbers... Just carry through the same structure used by major/minor:
>
Think this would be a superior naming-scheme.
However there are 2 audiences for the naming-scheme:
1. The developers, hackers (good scheme)
2. Users, Those who compile the kernel (bad scheme)

The naming-scheme you propose would make most sence for the first 
category.. but for the second (and I speak for myself).. they would not 
know that a X.X.X.2.1 would be RC1.
And one big part of changing the naming-scheme would be to get enough 
users to try out the proposed kernel to eliminate big bugs like in 
2.4.15 and 2.4.11.

Perhaps it is a PR-issue?

Then of course there is the matter of freezing development in a RC.. but 
that can be done no matter what kind of naming-scheme you use.

Best regards
Per-Olof Pettersson

