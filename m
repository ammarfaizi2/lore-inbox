Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263231AbUC3AET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 19:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbUC3AES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 19:04:18 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:2159 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263231AbUC3ACT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 19:02:19 -0500
Date: Mon, 29 Mar 2004 15:04:10 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Introduce mask ADT, rebuild cpumask_t and nodemask_t
 [0/22]
Message-Id: <20040329150410.7ed30da1.pj@sgi.com>
In-Reply-To: <1080600241.6742.20.camel@arrakis>
References: <20040329041140.77ce66d2.pj@sgi.com>
	<1080600241.6742.20.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Matthew, for reviewing these, and the initial feedback.

I should give credit to Christoph Hellwig - he's the one who initially
recommended to me that I use a common ADT for both cpumask and nodemask,
about 4 months ago.  I will never admit in public how much time that
one line comment of his cost me ... ;-).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
