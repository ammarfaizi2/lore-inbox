Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263099AbUKTFX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263099AbUKTFX1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 00:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbUKTFUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 00:20:53 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:65466 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261709AbUKTFTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 00:19:17 -0500
Date: Fri, 19 Nov 2004 21:17:39 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: akpm@osdl.org, janis187@us.ibm.com, dvhltc@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] cpumask_t initializers
Message-Id: <20041119211739.7bee8bba.pj@sgi.com>
In-Reply-To: <1100915156.4653.13.camel@arrakis>
References: <1100915156.4653.13.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This parenthesis removing patch looks ok to me.
I won't be able to test it right away ... too much stuff.

[Happy Thanksgiving, Matthew.  Looks like my two week sabbatical
from the CKRM/cpuset discussion is taking long than planned ...
It will be a few more weeks before I can return to it.  -pj]

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
