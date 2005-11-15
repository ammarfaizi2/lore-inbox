Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbVKOTUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVKOTUz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 14:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVKOTUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 14:20:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:54690 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965009AbVKOTUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 14:20:54 -0500
Date: Tue, 15 Nov 2005 11:20:42 -0800
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Simon.Derr@bull.net, clameter@sgi.com, rohit.seth@intel.com
Subject: Re: [PATCH 03/05] mm rationalize __alloc_pages ALLOC_* flag names
Message-Id: <20051115112042.253ca3cf.pj@sgi.com>
In-Reply-To: <4379B0A7.3090803@yahoo.com.au>
References: <20051114040329.13951.39891.sendpatchset@jackhammer.engr.sgi.com>
	<20051114040353.13951.82602.sendpatchset@jackhammer.engr.sgi.com>
	<4379A399.1080407@yahoo.com.au>
	<20051115010303.6bc04222.akpm@osdl.org>
	<4379B0A7.3090803@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick suggested:
> ALLOC_DIP_NONE
> ALLOC_DIP_LESS
> ALLOC_DIP_MORE
> ALLOC_DIP_FULL

Sweet.  PATCH coming soon.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
