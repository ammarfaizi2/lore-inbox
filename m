Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbTDBCW0>; Tue, 1 Apr 2003 21:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261340AbTDBCW0>; Tue, 1 Apr 2003 21:22:26 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:26848 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261338AbTDBCWY>; Tue, 1 Apr 2003 21:22:24 -0500
Date: Wed, 2 Apr 2003 08:08:30 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Filesystem aio rdwr patchset
Message-ID: <20030402080830.A1499@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030401215957.A1800@in.ibm.com> <20030401220242.B1857@in.ibm.com> <20030401175502.B19660@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030401175502.B19660@infradead.org>; from hch@infradead.org on Tue, Apr 01, 2003 at 05:55:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 05:55:02PM +0100, Christoph Hellwig wrote:
> > +int blk_congestion_wait_async(int rw, long timeout)
> 
> Isn't the name a bit silly? :)
> 
Yes, I'm hopelessly bad with names :(  
Could you suggest something saner ? 

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

