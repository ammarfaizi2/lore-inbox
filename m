Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269049AbUHZPaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269049AbUHZPaU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 11:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269056AbUHZPaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 11:30:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:41945 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S269049AbUHZPaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 11:30:14 -0400
Subject: Re: [PATCH 2/2] Hotplug CPU vs TASK_ZOMBIEs: The Sequel to Hotplug
	CPU vs TASK_DEAD
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <1093507097.29319.2510.camel@bach>
References: <20040822013402.5917b991.akpm@osdl.org>
	 <1093299523.5284.70.camel@pants.austin.ibm.com>
	 <1093475339.7056.6.camel@pants.austin.ibm.com>
	 <1093507097.29319.2510.camel@bach>
Content-Type: text/plain
Message-Id: <1093534187.4249.5.camel@biclops.private.network>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 10:29:47 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 02:58, Rusty Russell wrote:
> Name: Hotplug CPU vs TASK_ZOMBIEs: The Sequel to Hotplug CPU vs TASK_DEAD
> Status: Tested on 2.6.8.1-mm4
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Depends: Misc/stop_machine-nicksched-yield.patch.gz

Where can I get stop_machine-nicksched-yield.patch?  I assume this fixes
the interaction between nicksched and stop_machine_run?

Nathan

