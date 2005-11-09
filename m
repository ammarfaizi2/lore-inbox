Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbVKIWTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbVKIWTP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbVKIWTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:19:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47319 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030447AbVKIWTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:19:14 -0500
Date: Wed, 9 Nov 2005 14:18:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jody McIntyre <scjody@modernduck.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Brown, Len" <len.brown@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       "Luck, Tony" <tony.luck@intel.com>, Ben Collins <bcollins@debian.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Roland Dreier <rolandd@cisco.com>, Dave Jones <davej@codemonkey.org.uk>,
       Jens Axboe <axboe@suse.de>, Dave Kleikamp <shaggy@austin.ibm.com>,
       Steven French <sfrench@us.ibm.com>
Subject: Re: merge status
In-Reply-To: <20051109221201.GE14318@conscoop.ottawa.on.ca>
Message-ID: <Pine.LNX.4.64.0511091417540.4627@g5.osdl.org>
References: <20051109133558.513facef.akpm@osdl.org> <20051109221201.GE14318@conscoop.ottawa.on.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Nov 2005, Jody McIntyre wrote:

> On Wed, Nov 09, 2005 at 01:35:58PM -0800, Andrew Morton wrote:
> > 
> > -rw-r--r--    1 akpm     akpm        71651 Nov  9 11:19 git-ieee1394.patch
> 
> I thought the two-week window was only for new stuff, not
> bugfixes/cleanup

If you have a 71kB patch, it definitely counts as new stuff and not just 
trivial bugfixes.

		Linus
