Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030703AbWJDCDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030703AbWJDCDv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 22:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030704AbWJDCDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 22:03:51 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:57021 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030703AbWJDCDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 22:03:50 -0400
Date: Tue, 3 Oct 2006 19:03:41 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>, Joe Korty <joe.korty@ccur.com>
Cc: reinette.chatre@linux.intel.com, linux-kernel@vger.kernel.org,
       inaky@linux.intel.com
Subject: Re: [PATCH] bitmap: bitmap_parse takes a kernel buffer instead of a
 user buffer
Message-Id: <20061003190341.1f0d4601.pj@sgi.com>
In-Reply-To: <20061003163936.d8e26629.akpm@osdl.org>
References: <200610030816.27941.reinette.chatre@linux.intel.com>
	<20061003163936.d8e26629.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe that bitmap_parse() was contributed by Joe Korty.

Let's add him to this cc list too.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
