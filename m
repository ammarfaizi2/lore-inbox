Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269568AbUHZUDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269568AbUHZUDb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269461AbUHZTyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:54:14 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:15327 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S269528AbUHZTvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:51:15 -0400
Message-ID: <412E3EEB.5010603@ttnet.net.tr>
Date: Thu, 26 Aug 2004 22:50:03 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: Linux 2.4.28-pre2
References: <412E012F.4050503@ttnet.net.tr> <20040826191501.GA12772@fs.tum.de>
In-Reply-To: <20040826191501.GA12772@fs.tum.de>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Thu, Aug 26, 2004 at 06:26:39PM +0300, O.Sezer wrote:
> 
> 
>>Hi Marcelo:
>>
>>
>>>Also a bunch of gcc 3.4 fixes, hopefully we are done
>>>with that now.
>>
>>Fairly close, but not complete. You need the two patches at:
>>...
> 
> 
> I've found six compile errors in -pre2 with gcc 3.4 I'll send patches 
> for.

Which are they, I'm curious?

> There are still tons of warnings for lvalues and a few other warnings, 

Are there more other than the two patches I referenced fix and the
five I listed? Which are they?

> but I don't see a pressing need to fix these:
> 
> They are not a real problem with gcc 3.4, and whether gcc 3.5 will ever 
> be supported as compiler for kernel 2.4 is a question whose answer lies 
> far in the future.

That is a valid point but it'd be sad if gcc3.5 wouldn't be supported.

> cu
> Adrian
> 

Cheers.
Ozkan
