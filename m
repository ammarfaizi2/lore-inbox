Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264067AbUEMKwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbUEMKwS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 06:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbUEMKwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 06:52:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:33205 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264073AbUEMKwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 06:52:17 -0400
Date: Thu, 13 May 2004 03:51:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
Message-Id: <20040513035134.2e9013ea.akpm@osdl.org>
In-Reply-To: <20040513114520.A8442@infradead.org>
References: <20040513032736.40651f8e.akpm@osdl.org>
	<20040513114520.A8442@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> > +hugetlb_shm_group-sysctl-gid-0-fix.patch
> > 
> >  Don't make gid 0 special for hugetlb shm.
> 
> As Oracle has agreed on fixing their DB to use hugetlbfs could we
> please stop doctoring around on this broken patch and revert it.

Once I'm convinced that kernel.org kernels will be able to run applications
which vendor kernels will run, sure.

We're nowhere near that, and your continual whining gets us no closer.
