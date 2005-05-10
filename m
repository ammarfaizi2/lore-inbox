Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVEJOjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVEJOjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 10:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVEJOjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 10:39:18 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:18345 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261629AbVEJOjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 10:39:14 -0400
Date: Tue, 10 May 2005 10:38:39 -0400
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, jfbeam@bluetronic.net,
       nico-kernel@schottelius.org, linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-ID: <20050510143838.GG2297@csclub.uwaterloo.ca>
References: <20050419121530.GB23282@schottelius.org> <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net> <20050506211455.3d2b3f29.akpm@osdl.org> <20050510002121.7076feb6.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050510002121.7076feb6.pj@sgi.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 12:21:21AM -0700, Paul Jackson wrote:
> Yes - it's all there.  Sometimes the ways to discover it aren't pretty,
> but that's one thing that libraries are good for - to wrap such detail.

And then when the kernel adds something new, you update one library
rather than 1000s of applications.

Perhaps making it hard to get at without a certainl library is a good
way to avoid too many applications poling at it just because they can.

Len Sorensen
