Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264931AbUD2T1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264931AbUD2T1m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 15:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264932AbUD2T1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 15:27:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:3996 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264931AbUD2T1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 15:27:40 -0400
Date: Thu, 29 Apr 2004 12:27:38 -0700
From: Chris Wright <chrisw@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: Christoph Hellwig <hch@lst.de>, erikj@subway.americas.sgi.com,
       chrisw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
Message-ID: <20040429122738.U22989@build.pdx.osdl.net>
References: <Pine.SGI.4.53.0404261656230.591647@subway.americas.sgi.com> <20040426163955.X21045@build.pdx.osdl.net> <Pine.SGI.4.53.0404271546410.632984@subway.americas.sgi.com> <20040428145503.GA999@lst.de> <20040429122026.2ad7884e.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040429122026.2ad7884e.pj@sgi.com>; from pj@sgi.com on Thu, Apr 29, 2004 at 12:20:26PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul Jackson (pj@sgi.com) wrote:
> >  - without any user merging doesn't make sense
> 
> Could you try restating this particular comment, Christoph?
> I am failing to make any sense of it.

Same thing I was trying to get across.  Merging an infrastructure with
no users is a tough sell.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
