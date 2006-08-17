Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWHQQUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWHQQUB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 12:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWHQQUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 12:20:01 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:62670 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964855AbWHQQT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 12:19:59 -0400
Date: Thu, 17 Aug 2006 21:49:06 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 4/7] UBC: syscalls (user interface)
Message-ID: <20060817161906.GA23627@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <44E33893.6020700@sw.ru> <44E33C3F.3010509@sw.ru> <20060817110940.GC19127@in.ibm.com> <44E4778B.1020808@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E4778B.1020808@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 06:04:59PM +0400, Kirill Korotaev wrote:
> Please, keep in mind. This patch set can be extended in infinite number
> of ways. But!!! It contains only the required minimal functionality.

Sure ..But going by this it should mean that we don't see any code which 
hints of heirarchy (->parent)? :)

> When we are to add code requiring to know about limit changes or fails
> or whatever we can always extend it accordingly.

-- 
Regards,
vatsa
