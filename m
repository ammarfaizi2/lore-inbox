Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVBNQIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVBNQIZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 11:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVBNQHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 11:07:34 -0500
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:2917 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261460AbVBNQH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 11:07:28 -0500
X-SBRSScore: None
X-IronPort-AV: i="3.88,199,1102287600"; 
   d="scan'208"; a="3380344:sNHT1101503048"
Message-ID: <4210CCB9.1050700@fujitsu-siemens.com>
Date: Mon, 14 Feb 2005 17:07:21 +0100
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       roland@redhat.com, jdike@addtoit.com, blaisorblade_spam@yahoo.it,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix wait_task_inactive race (was Re: Race condition in
 ptrace)
References: <42021E35.8050601@fujitsu-siemens.com> <4202C18F.5010605@yahoo.com.au> <42036C2C.5040503@fujitsu-siemens.com> <4203F40C.8040707@yahoo.com.au> <20050204143917.1f9507cb.akpm@osdl.org> <4204020F.2000501@yahoo.com.au> <42044D17.5040703@yahoo.com.au> <42058E52.8030306@yahoo.com.au> <20050206071935.GA19991@elte.hu> <4205C8EF.2000604@yahoo.com.au>
In-Reply-To: <4205C8EF.2000604@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Your one liner would fix the problem too, of course. The important
> thing at this stage is that it gets fixed for 2.6.11.

Sorry, have been off the net last week.

Thank you for the patches. Have tested Ingo's one liner.
It works fine for me, as expected.

Bodo
