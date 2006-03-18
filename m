Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932865AbWCRDfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932865AbWCRDfn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 22:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932864AbWCRDfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 22:35:43 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:62600 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932860AbWCRDfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 22:35:42 -0500
Date: Sat, 18 Mar 2006 14:34:44 +1100
From: Nathan Scott <nathans@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Christoph Hellwig <hch@infradead.org>, Suzuki <suzuki@in.ibm.com>,
       linux-fsdevel@vger.kernel.org,
       "linux-aio kvack.org" <linux-aio@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>, suparna <suparna@in.ibm.com>,
       akpm@osdl.org, linux-xfs@oss.sgi.com
Subject: Re: [RFC] Badness in __mutex_unlock_slowpath with XFS stress tests
Message-ID: <20060318143444.E568717@wobbly.melbourne.sgi.com>
References: <440FDF3E.8060400@in.ibm.com> <20060309120306.GA26682@infradead.org> <20060309223042.GC1135@frodo> <20060309224219.GA6709@infradead.org> <20060309231422.GD1135@frodo> <20060310005020.GF1135@frodo> <20060317172210.GP3914@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060317172210.GP3914@stusta.de>; from bunk@stusta.de on Fri, Mar 17, 2006 at 06:22:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 06:22:10PM +0100, Adrian Bunk wrote:
> On Fri, Mar 10, 2006 at 11:50:20AM +1100, Nathan Scott wrote:
> > Something like this (works OK for me)...
> 
> Is this 2.6.16 material?

Its been merged already.

cheers.

-- 
Nathan
