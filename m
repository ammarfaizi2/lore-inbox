Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267258AbUG2IfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267258AbUG2IfC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 04:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267238AbUG2IfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 04:35:01 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:53479 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267199AbUG2Iey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 04:34:54 -0400
Date: Thu, 29 Jul 2004 01:34:39 -0700
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: ak@suse.de, jbarnes@engr.sgi.com, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       lse-tech@lists.sourceforge.net
Subject: Re: [RFC][PATCH] Change pcibus_to_cpumask() to pcibus_to_node()
Message-Id: <20040729013439.5ab2afe3.pj@sgi.com>
In-Reply-To: <1090952283.18747.3.camel@arrakis>
References: <1090887007.16676.18.camel@arrakis>
	<20040727161628.56a03aec.ak@suse.de>
	<200407270815.39165.jbarnes@engr.sgi.com>
	<20040727175713.10a95ad6.ak@suse.de>
	<1090952283.18747.3.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew wrote:
> That will make this patch dependent on my nodemask_t patch,

Did you notice that Andrew included your most recently published
nodemask_t in 2.6.8-rc2-mm1?

Congratulations !

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
