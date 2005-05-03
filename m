Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVECPfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVECPfh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 11:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVECPfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 11:35:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43155 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261789AbVECPfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 11:35:24 -0400
Date: Tue, 3 May 2005 08:24:25 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, colpatch@us.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org
Subject: Re: [RFC PATCH] Dynamic sched domains (v0.5)
Message-Id: <20050503082425.2c87b82b.pj@sgi.com>
In-Reply-To: <20050503144416.GA3933@in.ibm.com>
References: <20050501190947.GA5204@in.ibm.com>
	<20050502110135.173cbdd7.pj@sgi.com>
	<20050503144416.GA3933@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
>   No, all semantics continue to be the same as before

Good.

> I have trimmed the requirements to do only the absolute minimal in
> kernel space

Good.

> Partitioning of the system ... done through user space

Ok.

> Remove unnecessary scheduler load balancing ...

Ok.

Thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
