Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUG1WEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUG1WEQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUG1WEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:04:16 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:13283 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264377AbUG1WEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:04:14 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] don't pass mem_map into init functions
Date: Wed, 28 Jul 2004 14:58:37 -0700
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
Message-Id: <200407281458.37344.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 28, 2004 1:55 pm, Dave Hansen wrote:
> Compile tested on SMP x86 and NUMAQ.  I plan to give it a run on ppc64
> in a bit.  I'd appreciate if one of the ia64 guys could make sure it's
> OK for them as well.

It *looks* ok.  I'll give it a whirl to make sure.

Jesse
