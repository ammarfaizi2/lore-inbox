Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbVKIWN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbVKIWN5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbVKIWN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:13:56 -0500
Received: from [205.233.219.253] ([205.233.219.253]:18359 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1030438AbVKIWNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:13:55 -0500
Date: Wed, 9 Nov 2005 17:12:01 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Brown, Len" <len.brown@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       "Luck, Tony" <tony.luck@intel.com>, Ben Collins <bcollins@debian.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Roland Dreier <rolandd@cisco.com>, Dave Jones <davej@codemonkey.org.uk>,
       Jens Axboe <axboe@suse.de>, Dave Kleikamp <shaggy@austin.ibm.com>,
       Steven French <sfrench@us.ibm.com>
Subject: Re: merge status
Message-ID: <20051109221201.GE14318@conscoop.ottawa.on.ca>
References: <20051109133558.513facef.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109133558.513facef.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 01:35:58PM -0800, Andrew Morton wrote:
> 
> We're at day 12 of the two-week window, time for a quick peek at
> outstanding patches in the subsystem trees.
> 
> -rw-r--r--    1 akpm     akpm        71651 Nov  9 11:19 git-ieee1394.patch

I thought the two-week window was only for new stuff, not
bugfixes/cleanup.  Did I misread something?  If so, oh well, these
changes will have to wait for 2.6.16.  I don't feel comfortable sending
up something that's only been in -mm for 2 days.

Cheers,
Jody
