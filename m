Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132220AbRCaESq>; Fri, 30 Mar 2001 23:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132226AbRCaESg>; Fri, 30 Mar 2001 23:18:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59144 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132220AbRCaESY>;
	Fri, 30 Mar 2001 23:18:24 -0500
Date: Sat, 31 Mar 2001 05:54:51 +0200
From: Jens Axboe <axboe@suse.de>
To: James Washer <washer@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: max_sector support for scsi in 2.4.3??
Message-ID: <20010331055451.A17130@suse.de>
In-Reply-To: <OF6341F380.9BF6BA2B-ON88256A1F.0076CA5A@LocalDomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF6341F380.9BF6BA2B-ON88256A1F.0076CA5A@LocalDomain>; from washer@us.ibm.com on Fri, Mar 30, 2001 at 01:41:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30 2001, James Washer wrote:
> In 2.4.2-ac9,  max_sectors support was added to the SCSI midlayer. I was
> somewhat expecting to see that make it into 2.4.3, but it seems not.
> 
> Can anyone shed some light on why?

The max_sector patch is in no way critical (ie a feature, not a
bug fix), so it'll be merged along with the other stuff in the ac
tree eventually.

-- 
Jens Axboe

