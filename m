Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVEENQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVEENQR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 09:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbVEENQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 09:16:15 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:1717 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262100AbVEENPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 09:15:09 -0400
Date: Thu, 5 May 2005 18:58:21 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Paul Jackson <pj@sgi.com>,
       Simon Derr <Simon.Derr@bull.net>, lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC PATCH] Dynamic sched domains (v0.5)
Message-ID: <20050505132820.GB4028@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050501190947.GA5204@in.ibm.com> <4277F52B.8040908@us.ibm.com> <42781286.7080801@yahoo.com.au> <42781724.3010703@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42781724.3010703@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 05:28:20PM -0700, Matthew Dobson wrote:
> 
> build_disjoint_sched_domains(partition1, partition2)?  Or just
> partition_sched_domains(partition1, partition2)?  Partition and disjoint
> seem mildly redundant to me, for varying definitions of partition... ;)

partition_sched_domains sounds fine to me, Thanks

	-Dinakar
