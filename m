Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWAWHCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWAWHCn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 02:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWAWHCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 02:02:43 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:19096 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964853AbWAWHCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 02:02:42 -0500
Date: Sun, 22 Jan 2006 23:02:23 -0800
From: Paul Jackson <pj@sgi.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset: fix sparse warning
Message-Id: <20060122230223.e78a9d7f.pj@sgi.com>
In-Reply-To: <20060122120457.0b6a14c1.rdunlap@xenotime.net>
References: <20060122120457.0b6a14c1.rdunlap@xenotime.net>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy wrote:
> fix sparse warning: 
> ...
> +void cpuset_update_task_memory_state(void)

Acked-by: Paul Jackson <pj@sgi.com>

Thanks, Randy.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
