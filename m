Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262997AbVDLVOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbVDLVOO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbVDLVLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:11:01 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:11974 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262969AbVDLVGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 17:06:09 -0400
Message-ID: <425C3738.5090407@nortel.com>
Date: Tue, 12 Apr 2005 15:01:44 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Baudis <pasky@ucw.cz>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, torvalds@osdl.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: GIT license (Re: Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.1)
References: <200504120120.j3C1KII14991@adam.yggdrasil.com> <20050412014204.GB9145@pasky.ji.cz> <Pine.LNX.4.62.0504121037590.10150@numbat.sonytel.be> <20050412095048.GB22614@pasky.ji.cz> <20050412192924.GA26542@pasky.ji.cz>
In-Reply-To: <20050412192924.GA26542@pasky.ji.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Tue, Apr 12, 2005 at 11:50:48AM CEST, I got a letter

>>Well, yes, but the last merge point search may not be so simple:
>>
>>A --1---2----6---7
>>B    \   `-4-.  /
>>C     `-3-----5'
>>
>>Now, when at 7, your last merge point is not 1, but 2.
> 
> 
> ...and this is obviously wrong, sorry. You would lose 3 this way.

Wouldn't the delta betweeen 2 and 5 include any contribution from 3?

Chris
