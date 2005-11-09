Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030785AbVKIVvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030785AbVKIVvF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030784AbVKIVvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:51:05 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:9948 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030788AbVKIVvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:51:01 -0500
Subject: Re: merge status
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       "Luck, Tony" <tony.luck@intel.com>, Ben Collins <bcollins@debian.org>,
       Jody McIntyre <scjody@modernduck.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Roland Dreier <rolandd@cisco.com>, Dave Jones <davej@codemonkey.org.uk>,
       Jens Axboe <axboe@suse.de>, Dave Kleikamp <shaggy@austin.ibm.com>,
       Steven French <sfrench@us.ibm.com>
In-Reply-To: <20051109133558.513facef.akpm@osdl.org>
References: <20051109133558.513facef.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 16:50:40 -0500
Message-Id: <1131573041.8541.4.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-09 at 13:35 -0800, Andrew Morton wrote:
> -rw-r--r--    1 akpm     akpm       339882 Nov  9 11:19 git-scsi-misc.patch

This one is all 2.6.15 material.  I think I now (as of one minute ago)
have it updated to the last of the 2.6.15 (barring bug fix) patches.
I'd like to regression test it for a day or two, so I plan to request
the final merger on Friday.

James


