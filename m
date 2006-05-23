Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWEWGf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWEWGf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 02:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWEWGf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 02:35:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:52426 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751265AbWEWGf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 02:35:57 -0400
Date: Mon, 22 May 2006 23:35:45 -0700
From: Paul Jackson <pj@sgi.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: akpm@osdl.org, chrisw@sous-sol.org, clameter@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset: remove extra cpuset_zone_allowed check in
 __alloc_pages
Message-Id: <20060522233545.ad674527.pj@sgi.com>
In-Reply-To: <20060523063500.GB18769@moss.sous-sol.org>
References: <Pine.LNX.4.62.0602081010440.2648@schroedinger.engr.sgi.com>
	<20060522182356.fbea4aec.pj@sgi.com>
	<Pine.LNX.4.64.0605221858250.7165@schroedinger.engr.sgi.com>
	<20060522192248.b114fea3.pj@sgi.com>
	<Pine.LNX.4.64.0605221925350.7272@schroedinger.engr.sgi.com>
	<20060523063500.GB18769@moss.sous-sol.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Chris.

Signed-off-by: Paul Jackson <pj@sgi.com>

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
