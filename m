Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTJISFD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 14:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTJISFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 14:05:03 -0400
Received: from dp.samba.org ([66.70.73.150]:31671 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262321AbTJISE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 14:04:59 -0400
Date: Fri, 10 Oct 2003 04:04:05 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       arun.sharma@intel.com, torvalds@osdl.org
Subject: Re: 2.6.0-test7 BLK_DEV_FD dependence on ISA breakage
Message-ID: <20031009180404.GE17401@krispykreme>
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org> <16261.25288.125075.508225@gargle.gargle.HOWL> <20031009070505.00470202.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031009070505.00470202.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yeah, and there's been a metric mile of blab about it but I don't think
> we've actually settled on a correct+complete solution.
> 
> Perhaps we should just back it out and watch more closely next time someone
> tries to fix it?

Sounds good to me.

Anton
