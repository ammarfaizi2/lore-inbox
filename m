Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265058AbTLHQta (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265052AbTLHQrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:47:07 -0500
Received: from woozle.fnal.gov ([131.225.9.22]:43210 "EHLO woozle.fnal.gov")
	by vger.kernel.org with ESMTP id S265066AbTLHQoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:44:00 -0500
Date: Mon, 08 Dec 2003 10:43:56 -0600
From: Dan Yocum <yocum@fnal.gov>
Subject: Re: XFS merged in 2.4
In-reply-to: <Pine.LNX.4.44.0312080916220.889-100000@logos.cnet>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3FD4AA4C.7080102@fnal.gov>
Organization: Fermilab
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
References: <Pine.LNX.4.44.0312080916220.889-100000@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, Christoph, et al.,

Thanks for finally including XFS in the vanilla 2.4 tree.  We greatly 
appreciate it.

I hear that the acls and dmapi bits were excluded, but our ~300TB are used 
mainly for online data caching so we don't generally use these features.

Again, thanks for making my life somewhat easier.  :-)

Cheers,
Dan


Marcelo Tosatti wrote:
> FYI
> 
> Christoph reviewed XFS patch which changed generic code, and it was
> stripped down later to a set of changes which dont modify the code
> behaviour (except for a few bugfixes which should have been included
> separately anyway) and are pretty obvious.
> 
> So its that has been merged, along with fs/xfs/.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Dan Yocum
Sloan Digital Sky Survey, Fermilab  630.840.6509
yocum@fnal.gov, http://www.sdss.org
SDSS.  Mapping the Universe.  You are here.

