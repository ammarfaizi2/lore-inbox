Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268247AbUIJFrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268247AbUIJFrc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 01:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268250AbUIJFpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 01:45:34 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:44689 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268247AbUIJFp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 01:45:28 -0400
Message-ID: <414134A0.90101@yahoo.com.au>
Date: Fri, 10 Sep 2004 14:59:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: [pagevec] resize pagevec to O(lg(NR_CPUS))
References: <20040909163929.GA4484@logos.cnet> <20040909155226.714dc704.akpm@osdl.org> <20040909230905.GO3106@holomorphy.com> <20040909162245.606403d3.akpm@osdl.org> <20040910000717.GR3106@holomorphy.com> <414133EB.8020802@yahoo.com.au>
In-Reply-To: <414133EB.8020802@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> 
> That said, I *don't* think this should go in hastily.
> 

Of course, I would be happy for it to if it is shown to improve
things...
