Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265994AbUFPB14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265994AbUFPB14 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 21:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265995AbUFPB14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 21:27:56 -0400
Received: from lakermmtao05.cox.net ([68.230.240.34]:34732 "EHLO
	lakermmtao05.cox.net") by vger.kernel.org with ESMTP
	id S265994AbUFPB1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 21:27:54 -0400
In-Reply-To: <200406151938.02613.eric@cisu.net>
References: <20040615205753.GA24380@lst.de> <200406151938.02613.eric@cisu.net>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <63301070-BF34-11D8-95EB-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: more files with licenses that aren't GPL-compatible
Date: Tue, 15 Jun 2004 21:27:53 -0400
To: eric@cisu.net
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 15, 2004, at 20:38, Eric wrote:
> On Tuesday 15 June 2004 03:57 pm, Christoph Hellwig wrote:
>> 	Permission is hereby granted for the distribution of this firmware
>> 	image as part of a Linux or other Open Source operating system kernel
>> 	in text or binary form as required.

Permission is legally granted

>> 	This firmware may not be modified and may only be used with
>> 	Keyspan hardware.  Distribution and/or Modification of the
>> 	keyspan.c driver which includes this firmware, in whole or in
>> 	part, requires the inclusion of this statement."

But we can't actually distribute this file under GPL because we are
not allowed to modify it.  They own the copyright, so they can release 
it
under any terms that they want.  One of their terms is that we can make
copies and give them to people.  The other term is that nobody but them
can change it.  The two aren't incompatible, but the second is anti-GPL.

> Unredistributable? Am I mistaken? It says permission is given to 
> redistribute
> this piece as part of the linux kernel. You just can't modify it. 
> Although it
> is unquestionably not a very permissive license, it's inclusion is not
> detrimental to the kernel.

Unfortunately the GPL requires that everybody has the right to *modify* 
and
distribute *modified* copies of any files released under it.  If a file 
is to be
distributed as a part of the GPLed Linux kernel must also follow GPL.

The relevant portion of the GPL:
> [...snip...]
>
> You may modify your copy or copies of the Program or any portion of 
> it, thus
> forming a work based on the Program, and copy and distribute such
> modifications or work under the terms of Section 1 above, provided 
> that you
> also meet all of these conditions:
>
> [...snip...]
>
> b)	You must cause any work that you distribute or publish, that in 
> whole or
> 	in part contains or is derived from the Program or any part thereof, 
> to be
> 	licensed as a whole at no charge to all third parties under the terms 
> of
> 	this License.
>
> [...snip...]

Cheers,
Kyle Moffett

