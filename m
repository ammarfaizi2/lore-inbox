Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265237AbUG1WGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUG1WGy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbUG1WGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:06:54 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:53659 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265237AbUG1WGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:06:50 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] don't pass mem_map into init functions
Date: Wed, 28 Jul 2004 15:01:19 -0700
User-Agent: KMail/1.6.2
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-mm <linux-mm@kvack.org>,
       LSE <lse-tech@lists.sourceforge.net>, Anton Blanchard <anton@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1091048123.2871.435.camel@nighthawk>
In-Reply-To: <1091048123.2871.435.camel@nighthawk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407281501.19181.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 28, 2004 1:55 pm, Dave Hansen wrote:
> Compile tested on SMP x86 and NUMAQ.  I plan to give it a run on ppc64
> in a bit.  I'd appreciate if one of the ia64 guys could make sure it's
> OK for them as well.

Which tree is this against?  It doesn't apply to the bk tree or 
linux-2.6.8-rc2-mm1.

Thanks,
Jesse
