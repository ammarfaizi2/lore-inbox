Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVEJHVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVEJHVt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 03:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVEJHVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 03:21:48 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:32459 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261568AbVEJHVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 03:21:36 -0400
Date: Tue, 10 May 2005 00:21:21 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jfbeam@bluetronic.net, nico-kernel@schottelius.org,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-Id: <20050510002121.7076feb6.pj@sgi.com>
In-Reply-To: <20050506211455.3d2b3f29.akpm@osdl.org>
References: <20050419121530.GB23282@schottelius.org>
	<Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net>
	<20050506211455.3d2b3f29.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Probably these things can be worked out via the get/set_affinity() syscalls
> and/or via the cpuset sysfs interfaces, but it isn't as simple as you're
> assuming.

Yes - it's all there.  Sometimes the ways to discover it aren't pretty,
but that's one thing that libraries are good for - to wrap such detail.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
