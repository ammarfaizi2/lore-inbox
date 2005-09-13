Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVIMF7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVIMF7f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 01:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVIMF7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 01:59:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11722 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932320AbVIMF7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 01:59:35 -0400
Date: Mon, 12 Sep 2005 22:59:29 -0700
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert mempolicy.c to nodemasks, take 2
Message-Id: <20050912225929.26aca3ad.pj@sgi.com>
In-Reply-To: <20050913040107.GA21417@wotan.suse.de>
References: <20050913040107.GA21417@wotan.suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> Convert mempolicies to nodemask_t

Acked-by: Paul Jackson <pj@sgi.com>

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
