Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbUBZUC7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUBZUC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:02:59 -0500
Received: from lvs00-fl-n02.valueweb.net ([216.219.253.98]:65444 "EHLO
	ams002.ftl.affinity.com") by vger.kernel.org with ESMTP
	id S262841AbUBZUC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:02:56 -0500
Message-ID: <403E4CDF.3030300@coyotegulch.com>
Date: Thu, 26 Feb 2004 14:45:35 -0500
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: "Nakajima, Jun" <jun.nakajima@intel.com>, richard.brunner@amd.com,
       linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD64
References: <7F740D512C7C1046AB53446D37200173EA28A5@scsmsx402.sc.intel.com> <403E4681.20603@techsource.com>
In-Reply-To: <403E4681.20603@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> In other words, Intel's implementation deviates from the architecture as 
> defined by AMD.  So it's not 100% compatible.  I just want this point to 
> be clear.

There may exist non-instruction-set differences between the chips as 
well. Opteron systems (which have per-CPU memory control) operate as 
NUMA machines; will the same be true for any of Intel's ia32e chips?

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Software Invention for High-Performance Computing

