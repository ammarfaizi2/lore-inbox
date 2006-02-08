Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbWBHSGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbWBHSGe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWBHSGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:06:34 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:53914 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030408AbWBHSGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:06:32 -0500
Date: Wed, 8 Feb 2006 10:06:23 -0800
From: Paul Jackson <pj@sgi.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How in tarnation do I git v2.6.16-rc2?  hg died and I still
 don't git git
Message-Id: <20060208100623.bee5c990.pj@sgi.com>
In-Reply-To: <1139421223.28484.22.camel@camp4.serpentine.com>
References: <20060208070301.1162e8c3.pj@sgi.com>
	<1139421223.28484.22.camel@camp4.serpentine.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Using Mercurial, pull from here instead:
> 
> hg pull http://master.kernel.org/hg/linux-2.6

That works.

On another thread, Matt Mackall asks we not change
our default URL to the above master.kernel site,
as it has much less bandwidth.

And he says he should have the recommended site
back up shortly:

	http://www.kernel.org/hg/linux-2.6

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
