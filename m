Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVCNEnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVCNEnQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 23:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVCNEnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 23:43:15 -0500
Received: from stark.xeocode.com ([216.58.44.227]:59269 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261523AbVCNEnG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 23:43:06 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Greg Stark <gsstark@mit.edu>, s0348365@sms.ed.ac.uk,
       linux-kernel@vger.kernel.org, pmcfarland@downeast.net
Subject: Re: OSS Audio borked between 2.6.6 and 2.6.10
References: <87u0ng90mo.fsf@stark.xeocode.com>
	<200503130152.52342.pmcfarland@downeast.net>
	<874qff89ob.fsf@stark.xeocode.com>
	<200503140103.55354.s0348365@sms.ed.ac.uk>
	<87sm2y7uon.fsf@stark.xeocode.com>
	<20050313200753.20411bdb.akpm@osdl.org>
In-Reply-To: <20050313200753.20411bdb.akpm@osdl.org>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 13 Mar 2005 23:42:54 -0500
Message-ID: <87br9m7s8h.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> I would agree with that.  If it's in the tree and the config system offers
> it, it should work.  And if it _used_ to work, and no longer does so then
> double bad.

Er, yeah, it's not like this is a new card that some crufty old driver never
supported well. It worked fine in the past and got broke.

> Are you able to narrow it down to something more fine grained than "between
> 2.6.6 and 2.6.9-rc1"?

Er, I suppose I would have to build some more kernels. Ugh. Is there a good
place to start or do I have to just do a binary search?

-- 
greg

