Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbUCSBtr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 20:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbUCSBtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 20:49:47 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:7428 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262104AbUCSBtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 20:49:24 -0500
Date: Thu, 18 Mar 2004 17:48:42 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-Id: <20040318174842.65f693fe.pj@sgi.com>
In-Reply-To: <1079659184.8149.355.camel@arrakis>
References: <1079651064.8149.158.camel@arrakis>
	<20040318165957.592e49d3.pj@sgi.com>
	<1079659184.8149.355.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My goal is to stop the proliferation of open-coded references
> to node details as soon as possible.

A worthy goal.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
