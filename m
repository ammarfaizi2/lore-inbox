Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUHRMgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUHRMgW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 08:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbUHRMdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 08:33:51 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:54711 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266200AbUHRMaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 08:30:06 -0400
Date: Wed, 18 Aug 2004 17:59:49 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org, akpm@osdl.org,
       Suparna Bhattacharya <suparna@in.ibm.com>, litke@us.ibm.com,
       ebiederm@xmission.com
Subject: Re: [PATCH][6/6]Device abstraction for linear/raw view of the dump
Message-ID: <20040818122949.GB3597@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <20040817120239.GA3916@in.ibm.com> <20040817120531.GB3916@in.ibm.com> <20040817120717.GC3916@in.ibm.com> <20040817120809.GD3916@in.ibm.com> <20040817120911.GE3916@in.ibm.com> <20040817121017.GF3916@in.ibm.com> <20040817121332.GG3916@in.ibm.com> <175200000.1092783201@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175200000.1092783201@flay>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Tue, Aug 17, 2004 at 03:53:21PM -0700, Martin J. Bligh wrote:
> > This patch contains the code that enables us to access the 
> > previous kernel's memory as /dev/hmem.
> 
> One of the bits of feedback we got at kernel summit was that nobody
> liked the /dev/hmem name ... could we change it to /dev/oldmem, perhaps?

I'll change it to /dev/oldmem in the next iteration of the patches.

> 
> Thanks,
> 
> M.
> 
Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore
