Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264274AbUDUIoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbUDUIoi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 04:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbUDUIoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 04:44:38 -0400
Received: from mail.zmailer.org ([62.78.96.67]:42695 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S264274AbUDUIog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 04:44:36 -0400
Date: Wed, 21 Apr 2004 11:44:34 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org, postmaster@vger.kernel.org
Subject: Re: vger.kernel.org is listed by spamcop
Message-ID: <20040421084434.GL1749@mea-ext.zmailer.org>
References: <200404210722.32253.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404210722.32253.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 07:22:32AM +0200, Jan De Luyck wrote:
> Hello List,
> 
> Since I don't know who the admin is (I thought Larry?) of vger.kernel.org,
> I'm sending this mail here.

Ever heard of  postmaster@vger.kernel.org   type of addresses ?

> Since yesterday eve, 19PM GMT+2, I stopped receiving emails from
> linux-kernel.  Today, I investigated on the issue, and found (using
> mxverify) out that vger.kernel.org has been listed in the blacklist
> of spamcop.
> 
> http://www.spamcop.net/w3m?action=blcheck&ip=67.72.78.212
> 
> Unfortunately, all the email addresses I have are 'spamcopped' by the 
> respective ISP's.
> 
> Can action be undertaken by the admin so that all the world can once 
> again have the full gory^Wglory of LKML (and the other mailling lists
> @ vger)?

Reading SPAMCOP pages I think they are most unwilling to make
any exceptions.  Per this document:
   http://www.spamcop.net/fom-serve/cache/298.html

The only way to handle this is to have smarter people, who are always
vigilant enough to look deeply into the message headers and do realize
that some spam has leaked thru VGER's lists. They may report those 
_ONLY_ to VGER's postmaster (several people), who can (to an extent)
add keyword based filters to Majordomo.

Any single less savvy person receiving the list could still
accidentally get VGER again listed in a number of spam-block
lists.


Another would be to run the lists in fully CLOSED mode, which
would still let a bunch of viruses thru...  (filters are mostly
biting on those already, though.)  But it would be most nasty
mode in other forms...


> Thanks,
> Jan

/Matti Aarnio -- one of those   <postmaster@vger.kernel.org>
