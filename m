Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVGVDtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVGVDtr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 23:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVGVDrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 23:47:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19077 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262008AbVGVDqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 23:46:45 -0400
Date: Thu, 21 Jul 2005 20:46:31 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: matthltc@us.ibm.com, akpm@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, gh@us.ibm.com
Subject: Re: 2.6.13-rc3-mm1 (ckrm)
Message-Id: <20050721204631.1fb4d9a5.pj@sgi.com>
In-Reply-To: <42E03DD2.6020308@mbligh.org>
References: <20050715013653.36006990.akpm@osdl.org>
	<20050715150034.GA6192@infradead.org>
	<20050715131610.25c25c15.akpm@osdl.org>
	<20050717082000.349b391f.pj@sgi.com>
	<1121985448.5242.90.camel@stark>
	<20050721163227.661a5169.pj@sgi.com>
	<42E03DD2.6020308@mbligh.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> No offense, but I really don't see why this matters at all ... the stuff
> in -mm is what's under consideration for merging - what's in SuSE is ...

Yes - what's in SuSE doesn't matter, at least not directly.

No - we are not just considering the CKRM that is in *-mm now, but also
what can be expected to be proposed as part of CKRM in the future.

If the CPU controller is not in *-mm now, but if one might reasonably
expect it to be proposed as part of CKRM in the future, then we need to
understand that.  This is perhaps especially important in this case,
where there is some reason to suspect that this additional piece is
both non-trivial and essential to CKRM's purpose.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
