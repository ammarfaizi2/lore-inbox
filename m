Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbTEWOTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 10:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbTEWOTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 10:19:43 -0400
Received: from franka.aracnet.com ([216.99.193.44]:45219 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262855AbTEWOTm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 10:19:42 -0400
Date: Fri, 23 May 2003 07:32:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm8
Message-ID: <26160000.1053700350@[10.10.2.4]>
In-Reply-To: <1053673399.1547.27.camel@nighthawk>
References: <20030522021652.6601ed2b.akpm@digeo.com> <17990000.1053670694@[10.10.2.4]> <1053673399.1547.27.camel@nighthawk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>       1004     2.0% default_idle
>>        272     8.3% __copy_from_user_ll
>>        129     1.7% __d_lookup
>>         79     7.5% link_path_walk
> 
> I have to wonder if these are cache effects, or just noise.  Can you
> give oprofile a try with one of the cache performance counters?

No, but you can ;-)

M.

