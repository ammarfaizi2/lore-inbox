Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269558AbUJFW22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269558AbUJFW22 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269538AbUJFWZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:25:02 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:6875 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269558AbUJFWYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:24:09 -0400
Date: Wed, 06 Oct 2004 15:23:18 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <jgarzik@pobox.com>, Ingo Molnar <mingo@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org, judith@osdl.org
Subject: Re: new dev model (was Re: Default cache_hot_time value back to 10ms)
Message-ID: <44030000.1097101398@flay>
In-Reply-To: <4164489D.6040404@pobox.com>
References: <200410060042.i960gn631637@unix-os.sc.intel.com> <20041005205511.7746625f.akpm@osdl.org> <416374D5.50200@yahoo.com.au> <20041005215116.3b0bd028.akpm@osdl.org> <41637BD5.7090001@yahoo.com.au> <20041005220954.0602fba8.akpm@osdl.org> <416380D7.9020306@yahoo.com.au> <20041005223307.375597ee.akpm@osdl.org> <41638E61.9000004@pobox.com> <Pine.LNX.4.58.0410060512580.14349@devserv.devel.redhat.com> <4164489D.6040404@pobox.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> it is also correct that the pile of patches in the -mm tree mask the QA
>> effects of testing done on -mm, so testing -BK separately is just as
>> important at this stage.
> 
> The simple fact is that -mm doesn't receive _nearly_ the amount of testing that a 2.6.x -BK snapshot does, which in turn doesn't receive _nearly_ the amount of testing that a 2.6.x-rc release gets.

Not sure that's true. Personally I test all -mm releases, and not -bk 
snapshots ... I've heard similar from other people.

If everyone pushed their stuff through -mm, and it sat there for a few
days before going upstream, we'd get a much better opportunity to test.

M.

