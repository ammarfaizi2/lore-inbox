Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbUDBXgx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 18:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUDBXgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 18:36:53 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:29465 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261355AbUDBXgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 18:36:52 -0500
Date: Fri, 2 Apr 2004 15:35:18 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch 6/23] mask v2 - Replace cpumask_t with one using mask
Message-Id: <20040402153518.706d8464.pj@sgi.com>
In-Reply-To: <1080944675.9787.113.camel@arrakis>
References: <20040401122802.23521599.pj@sgi.com>
	<20040401131136.792495fa.pj@sgi.com>
	<1080944675.9787.113.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What do you think about this?

Check out my patch 24 of 23, sent last night, which should make
cpumask_of_cpu() efficient for UP systems.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
