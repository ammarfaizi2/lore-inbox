Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWEAAZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWEAAZj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 20:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWEAAZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 20:25:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12997 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750794AbWEAAZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 20:25:38 -0400
Date: Mon, 1 May 2006 10:24:40 +1000
From: Nathan Scott <nathans@sgi.com>
To: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Bad page state in process 'nfsd' with xfs
Message-ID: <20060501102440.A1864834@wobbly.melbourne.sgi.com>
References: <4454D59C.7000501@dunaweb.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4454D59C.7000501@dunaweb.hu>; from zboszor@dunaweb.hu on Sun, Apr 30, 2006 at 05:19:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 30, 2006 at 05:19:56PM +0200, Zoltan Boszormenyi wrote:
> ...
> Or not. I had an FC3/x86-64 system until two days ago, now I have FC5/86-64.
> 
> When FC3 was installed I chose to format the partitions to XFS and since 
> then
> I had Oopses regularly with or without VMWare modules.

What was the stack trace for your oops...?

cheers.

-- 
Nathan
