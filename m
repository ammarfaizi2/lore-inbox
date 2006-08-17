Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWHQMLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWHQMLm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWHQMLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:11:42 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:933 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751032AbWHQMLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:11:41 -0400
Date: Thu, 17 Aug 2006 16:32:37 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
Message-ID: <20060817110237.GA19127@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <44E33893.6020700@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E33893.6020700@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 07:24:03PM +0400, Kirill Korotaev wrote:
> As the first step we want to propose for discussion
> the most complicated parts of resource management:
> kernel memory and virtual memory.

Do you have any plans to post a CPU controller? Is that tied to UBC
interface as well?

-- 
Regards,
vatsa
