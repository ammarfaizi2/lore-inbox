Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263000AbUEFUHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbUEFUHI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 16:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUEFUHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 16:07:08 -0400
Received: from waste.org ([209.173.204.2]:49891 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263000AbUEFUHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 16:07:06 -0400
Date: Thu, 6 May 2004 15:05:55 -0500
From: Matt Mackall <mpm@selenic.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Matthew Dobson <colpatch@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Joe Korty <joe.korty@ccur.com>,
       Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [PATCH mask 1/15] pj-fix-1-unifix
Message-ID: <20040506200555.GE28459@waste.org>
References: <20040506111814.62d1f537.pj@sgi.com> <20040506114629.74bea739.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040506114629.74bea739.pj@sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 11:46:29AM -0700, Paul Jackson wrote:

> -	printk("POSIX conformance testing by UNIFIX\n");

While this may make sense, I really don't see how it has anything to
do with the series.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
