Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267184AbUG1Xak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267184AbUG1Xak (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266749AbUG1X11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 19:27:27 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:30961 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S267331AbUG1XYF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 19:24:05 -0400
Subject: Re: [PATCH] don't pass mem_map into init functions
From: Dave Hansen <haveblue@us.ibm.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-mm <linux-mm@kvack.org>,
       LSE <lse-tech@lists.sourceforge.net>, Anton Blanchard <anton@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davidm@hpl.hp.com, tony.luck@intel.com
In-Reply-To: <200407281539.40049.jbarnes@engr.sgi.com>
References: <1091048123.2871.435.camel@nighthawk>
	 <200407281501.19181.jbarnes@engr.sgi.com>
	 <1091053187.2871.526.camel@nighthawk>
	 <200407281539.40049.jbarnes@engr.sgi.com>
Content-Type: text/plain
Message-Id: <1091056702.2871.617.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 16:18:22 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 15:39, Jesse Barnes wrote:
> You're missing this little bit from your patchset.  Cc'ing Tony and David.

Thanks for finding that.  That appears to be an ia64-ism, so I think the
rest of the patch is OK.

-- Dave

