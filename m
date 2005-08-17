Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVHRPB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVHRPB2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 11:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbVHRPB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 11:01:28 -0400
Received: from fmr24.intel.com ([143.183.121.16]:64686 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750823AbVHRPB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 11:01:28 -0400
Date: Wed, 17 Aug 2005 19:16:49 -0400
From: Benjamin LaHaise <bcrl@linux.intel.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [AIO] aio-2.6.13-rc6-B1
Message-ID: <20050817231649.GA25997@linux.intel.com>
References: <20050817184406.GA24961@linux.intel.com> <20050818100259.GA7060@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050818100259.GA7060@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 03:32:59PM +0530, Suparna Bhattacharya wrote:
> Using IPI Shortcut mode
> VFS: Cannot open root device "sda6" or unknown-block(8,6)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,6)

Are you sure the scsi driver is configured in?  This doesn't look related 
to any of the changes in the patch.  I'm going to be away from email for 
the next week, so you'll have to figure this out.

		-ben
