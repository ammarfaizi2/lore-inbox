Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWCUL2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWCUL2d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWCUL2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:28:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10369 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030299AbWCUL2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:28:32 -0500
Date: Tue, 21 Mar 2006 11:28:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: prasanna@in.ibm.com, ak@suse.de, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [2/3 PATCH] Kprobes: User space probes support- readpage hooks
Message-ID: <20060321112807.GB5460@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, prasanna@in.ibm.com, ak@suse.de,
	davem@davemloft.net, suparna@in.ibm.com, richardj_moore@uk.ibm.com,
	linux-kernel@vger.kernel.org
References: <20060320060745.GC31091@in.ibm.com> <20060320060931.GD31091@in.ibm.com> <20060320061014.GE31091@in.ibm.com> <20060320025311.419a44e3.akpm@osdl.org> <20060320134839.GF8662@in.ibm.com> <20060320181255.16932b0d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320181255.16932b0d.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 06:12:55PM -0800, Andrew Morton wrote:
> What does this entire feature *do*?  Why does Linux need it?

it's what dtrace does.  thus the marketing departments at ibm and redhat
decided to copy the features 1:1 instead of thinking what problem they
want to solve.

