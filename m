Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbVLQAFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbVLQAFu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 19:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbVLQAFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 19:05:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:48546 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932567AbVLQAFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 19:05:49 -0500
Date: Sat, 17 Dec 2005 11:05:22 +1100
From: Greg Banks <gnb@sgi.com>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: [PATCH 11/12] readahead: nfsd support
Message-ID: <20051217000522.GB30278@sgi.com>
References: <20051216130738.300284000@localhost.localdomain> <20051216131048.397266000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216131048.397266000@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 09:07:49PM +0800, Wu Fengguang wrote:
> ------------------------------------------------------------------------
> Here is some test output(8 nfsd; local mount with tcp,rsize=8192):

What are the numbers when you use a more realistic rsize like 32768? 

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
