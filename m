Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbVLJKCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbVLJKCM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 05:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbVLJKCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 05:02:12 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:3781 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965122AbVLJKCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 05:02:12 -0500
Date: Sat, 10 Dec 2005 02:02:01 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       clameter@sgi.com
Subject: Re: [PATCH 07/10] Cpuset: numa_policy_rebind cleanup
Message-Id: <20051210020201.c84a9d3e.pj@sgi.com>
In-Reply-To: <20051210081922.12303.89583.sendpatchset@jackhammer.engr.sgi.com>
References: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
	<20051210081922.12303.89583.sendpatchset@jackhammer.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

I should have included you on the CC list for this set of ten cpuset
patches, a couple of which also apply to mempolicy.c.  Sorry I missed
you ... here's your very own custom personalized ping ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
