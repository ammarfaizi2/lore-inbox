Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287332AbRL3ELB>; Sat, 29 Dec 2001 23:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287333AbRL3EKv>; Sat, 29 Dec 2001 23:10:51 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:55231 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S287332AbRL3EKq>; Sat, 29 Dec 2001 23:10:46 -0500
Mime-Version: 1.0
Message-Id: <p05101000b8543fd5fab1@[10.0.0.42]>
Date: Sat, 29 Dec 2001 20:10:38 -0800
To: linux-kernel@vger.kernel.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Configure.help editorial policy
Cc: Timo Jantunen <jeti@iki.fi>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timo Jantunen <jeti@iki.fi> wrote:

>How about IBM. According to the datasheet at
>http://www.storage.ibm.com/hdd/desk/ds120gxp.htm
>
>Deskstar 120GXP with 120GB capacity has 24125472 sectors (123522416640
>bytes).
>
>That is 123.5GB if G=10^9 but 120.6GB if G=10^6*2^10 (and merely
>115.0GB if G=2^30).
>
>Horrible? Yes.
>
>(The same is true for 40GB and 80GB versions of 120GXP, and my (older
>model) 30GB and 40GB IBM drives.)

Please click on the "Models" link on the page you linked to and 
reconsider your position.  For abstract marketing purposes such as 
model and family names, IBM currently prefers to round down to 5GB 
increments, probably because 123.52GXP doesn't roll off the tongue 
quite so well as 120GXP.  That doesn't mean they use anything other 
than 1GB = 10^9 bytes when they get around to telling you exactly how 
much each model holds.

(It hasn't always been round-to-5GB.  For example one older family 
was the 22GXP.  But that's easy to understand: when the maximum 
shipping capacity was 22GB it presumably made more sense to round to 
1GB figures.)
-- 
Tim Seufert
