Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVILUl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVILUl0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVILUl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:41:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7836
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932129AbVILUlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:41:25 -0400
Date: Mon, 12 Sep 2005 13:41:22 -0700 (PDT)
Message-Id: <20050912.134122.54246336.davem@davemloft.net>
To: tcallawa@redhat.com
Cc: aurora-sparc-devel@lists.auroralinux.org, linux-kernel@vger.kernel.org,
       davem@redhat.com, sparclinux@vger.kernel.org
Subject: Re: [Aurora-sparc-devel] [2.6.13-rc6-git13/sparc64]: Slab
 corruption (possible stack or buffer-cache corruption)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1126536316.25031.66.camel@localhost.localdomain>
References: <Pine.BSO.4.62.0509121604360.5000@rudy.mif.pg.gda.pl>
	<1126536316.25031.66.camel@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Mon, 12 Sep 2005 09:45:16 -0500

> We've been seeing this intermittently on arthur since Aurora 1.0 (2.4).

That's amazing given that half of those SLAB functions in
the backtrace simply do not exist in 2.4.x :-)  Can you quote
a 2.4.x version of such a backtrace?  Thanks a lot.
