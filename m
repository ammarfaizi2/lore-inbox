Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTJISUW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 14:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbTJISUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 14:20:22 -0400
Received: from fmr04.intel.com ([143.183.121.6]:40342 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262369AbTJISUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 14:20:20 -0400
Message-ID: <3F85A670.10405@intel.com>
Date: Thu, 09 Oct 2003 11:18:24 -0700
From: Arun Sharma <arun.sharma@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: 2.6.0-test7 BLK_DEV_FD dependence on ISA breakage
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org>	<16261.25288.125075.508225@gargle.gargle.HOWL> <20031009070505.00470202.akpm@osdl.org>
In-Reply-To: <20031009070505.00470202.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Perhaps we should just back it out and watch more closely next time someone
> tries to fix it?

I'm fine with backing out the Kconfig part of the patch. Perhaps this is one of those things where an explicit list of platforms which do support this feature is unavoidable ? 

	-Arun



