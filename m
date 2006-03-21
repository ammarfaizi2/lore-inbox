Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751534AbWCUMQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbWCUMQA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 07:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWCUMQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 07:16:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27368 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751522AbWCUMQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 07:16:00 -0500
Date: Tue, 21 Mar 2006 12:15:50 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, ak@suse.de,
       Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, prasanna@in.ibm.com, suparna@in.ibm.com
Subject: Re: [2/3 PATCH] Kprobes: User space probes support- readpage hooks
Message-ID: <20060321121550.GA7009@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Richard J Moore <richardj_moore@uk.ibm.com>, ak@suse.de,
	Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
	linux-kernel@vger.kernel.org, prasanna@in.ibm.com,
	suparna@in.ibm.com
References: <20060321112807.GB5460@infradead.org> <OF765C98CD.EB612716-ON80257138.00400490-80257138.00405953@uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF765C98CD.EB612716-ON80257138.00400490-80257138.00405953@uk.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think you'll find it happened the other way round. Sun openly references
> my white papers. They even stole the name of an ancestor to kprobes. But
> who cares, it not relevant or particularly interesting whether the chicken
> or the egg came first.

I know your papers, too.  In fact dprobes' RPN program downloads are a far
better design than systemtap's generation of kernel code.  it's a pity that
you gave up on dprobes instead of applying the required work to it and
integrate it with other bits of a tracing framework.
