Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268147AbUIKNjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268147AbUIKNjh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 09:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268148AbUIKNjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 09:39:36 -0400
Received: from ozlabs.org ([203.10.76.45]:12011 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268147AbUIKNjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 09:39:36 -0400
Date: Sat, 11 Sep 2004 23:38:12 +1000
From: Anton Blanchard <anton@samba.org>
To: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Cc: Jakob Oestergaard <jakob@unthought.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Major XFS problems...
Message-ID: <20040911133812.GC32755@krispykreme>
References: <20040908123524.GZ390@unthought.net> <4142E3EB.3080308@pointblue.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4142E3EB.3080308@pointblue.com.pl>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In my expierence XFS, was right after JFS the worst and the slowest 
> filesystem ever made.

On our NFS benchmarks JFS is _significantly_ faster than ext3 and
reiserfs. It depends on your workload but calling JFS the worst and
slowest filesystem ever made is unfair.

Anton
