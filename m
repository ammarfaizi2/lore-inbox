Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030465AbVKIA14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbVKIA14 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbVKIA14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:27:56 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:61150 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030465AbVKIA1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:27:55 -0500
Date: Tue, 8 Nov 2005 16:27:44 -0800
From: Paul Jackson <pj@sgi.com>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: keep in sync with -mm tree?
Message-Id: <20051108162744.3266eb70.pj@sgi.com>
In-Reply-To: <43706127.8020304@reub.net>
References: <56rz6-8re-25@gated-at.bofh.it>
	<56rSs-mJ-3@gated-at.bofh.it>
	<43706127.8020304@reub.net>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

reuben wrote:
> Last time I tried a broken-out- tarball I ended up watching a heap of fuzzy 
> apply's then a part of the patch which was entirely rejected,

Usually when I see that, it is because I did not religiously get
the exact right 2.6.*-rc* version as a base for the broken-out
patch set.


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
