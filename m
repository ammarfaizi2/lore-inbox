Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752432AbWCPRcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbWCPRcI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437AbWCPRcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:32:08 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:62104 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1752432AbWCPRcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:32:06 -0500
Date: Thu, 16 Mar 2006 09:31:49 -0800
From: Paul Jackson <pj@sgi.com>
To: vatsa@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu_exclusive feature of cpuset broken?
Message-Id: <20060316093149.a82d6bb6.pj@sgi.com>
In-Reply-To: <20060316170135.GB6548@in.ibm.com>
References: <20060316152848.GA6548@in.ibm.com>
	<20060316083836.f598ff45.pj@sgi.com>
	<20060316170135.GB6548@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Did you try with the 'cd a' (in other words turn on exclusive 
> property of cpuset 'a')?

Yes - that works fine.  I've never seen any problem like this.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
