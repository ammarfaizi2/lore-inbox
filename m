Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131568AbRAXS3p>; Wed, 24 Jan 2001 13:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132566AbRAXS3c>; Wed, 24 Jan 2001 13:29:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23047 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132783AbRAXS3P>;
	Wed, 24 Jan 2001 13:29:15 -0500
Date: Wed, 24 Jan 2001 19:27:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Heitzso <xxh1@cdc.gov>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1pre10 sr.c compile warning
Message-ID: <20010124192749.A25680@suse.de>
In-Reply-To: <B7F9A3E3FDDDD11185510000F8BDBBF2049E804C@mcdc-atl-5.cdc.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B7F9A3E3FDDDD11185510000F8BDBBF2049E804C@mcdc-atl-5.cdc.gov>; from xxh1@cdc.gov on Wed, Jan 24, 2001 at 01:18:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24 2001, Heitzso wrote:
> fyi
> 
> while compiling 2.4.1pre10 sr.c compile
> reports error in get_capabilities()
> "too few arguments for format"

yeah, just add an 'i' as the argument.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
