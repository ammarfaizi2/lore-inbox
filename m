Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266748AbUIMQYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266748AbUIMQYP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 12:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUIMQXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 12:23:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:17874 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266748AbUIMQWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 12:22:31 -0400
Date: Mon, 13 Sep 2004 09:22:05 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: akpm@osdl.org, colpatch@us.ibm.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
Message-Id: <20040913092205.3e4214a9.pj@sgi.com>
In-Reply-To: <732210000.1095091880@[10.10.2.4]>
References: <20040913015003.5406abae.akpm@osdl.org>
	<650660000.1095088173@[10.10.2.4]>
	<20040913081841.6689d34c.pj@sgi.com>
	<732210000.1095091880@[10.10.2.4]>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> so maybe it'll work now ;-)

It's not working for me - on a small ia64 SN2, it crashes during boot. 
Somewhere between the 32 and 42 patch of Andrews broken out set of 436
patches ... I'm still in the binary search loop.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
