Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVDBMQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVDBMQV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 07:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVDBMQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 07:16:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:1992 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261405AbVDBMQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 07:16:07 -0500
Date: Sat, 2 Apr 2005 04:14:49 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: blosure@sgi.com, mochel@digitalimplant.org, linux-kernel@vger.kernel.org
Subject: Re: new SGI TIOCX driver in *-mm driver model locking broken
Message-Id: <20050402041449.352b99da.pj@engr.sgi.com>
In-Reply-To: <20050402035131.53c9e4c5.akpm@osdl.org>
References: <20050402034313.4aa994f5.pj@engr.sgi.com>
	<20050402035131.53c9e4c5.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Pat did a patch, but nobody's tested it yet.

It compiles.  I have idea how to test it any further.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
