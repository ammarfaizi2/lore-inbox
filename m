Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUC0Awo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 19:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbUC0Awo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 19:52:44 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:17235 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261530AbUC0Awn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 19:52:43 -0500
Date: Fri, 26 Mar 2004 16:50:10 -0800
From: Paul Jackson <pj@sgi.com>
To: "David S. Miller" <davem@redhat.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org,
       wli@holomorphy.com
Subject: Re: Sparc64, cpumask_t and struct arguments (was: [PATCH] Introduce
 nodemask_t ADT)
Message-Id: <20040326165010.7560496a.pj@sgi.com>
In-Reply-To: <20040326160823.224150c8.davem@redhat.com>
References: <20040320031843.GY2045@holomorphy.com>
	<20040320000235.5e72040a.pj@sgi.com>
	<20040320111340.GA2045@holomorphy.com>
	<20040322171243.070774e5.pj@sgi.com>
	<20040323020940.GV2045@holomorphy.com>
	<20040322183918.5e0f17c7.pj@sgi.com>
	<20040323031345.GY2045@holomorphy.com>
	<20040322193628.4278db8c.pj@sgi.com>
	<20040323035921.GZ2045@holomorphy.com>
	<20040325012457.51f708c7.pj@sgi.com>
	<20040325101827.GO791@holomorphy.com>
	<20040326143648.5be0e221.pj@sgi.com>
	<20040326145423.74c1ce52.davem@redhat.com>
	<20040326152927.5992b011.pj@sgi.com>
	<20040326160823.224150c8.davem@redhat.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> that is why there are no cpumask_t references :-)

Ok - thanks.  Guess I won't worry about it too much for now.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
