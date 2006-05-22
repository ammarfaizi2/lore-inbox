Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWEVXyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWEVXyh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 19:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWEVXyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 19:54:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:21223 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751313AbWEVXyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 19:54:36 -0400
Date: Mon, 22 May 2006 16:54:11 -0700
From: Paul Jackson <pj@sgi.com>
To: Dave Peterson <dsp@llnl.gov>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       ak@suse.de, linux-mm@kvack.org, garlick@llnl.gov, mgrondona@llnl.gov
Subject: Re: [PATCH (try #2)] mm: avoid unnecessary OOM kills
Message-Id: <20060522165411.48284107.pj@sgi.com>
In-Reply-To: <7.0.0.16.2.20060522154857.02429fd8@llnl.gov>
References: <200605222143.k4MLhs2w021071@calaveras.llnl.gov>
	<20060522151227.37fd9e51.pj@sgi.com>
	<7.0.0.16.2.20060522154857.02429fd8@llnl.gov>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave wrote:
> I'll add back the printk_ratelimit() and make a new patch...

Good.

> How about the following?

Good.

Thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
