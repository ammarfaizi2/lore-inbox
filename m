Return-Path: <linux-kernel-owner+w=401wt.eu-S932654AbXARW11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbXARW11 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 17:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbXARW11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 17:27:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40575 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932654AbXARW10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 17:27:26 -0500
Date: Thu, 18 Jan 2007 22:27:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org,
       raisch@de.ibm.com
Subject: Re: [PATCH/RFC 2.6.21] ehca: ehca_uverbs.c: refactor ehca_mmap() for better readability
Message-ID: <20070118222720.GA5385@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <rdreier@cisco.com>,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	openfabrics-ewg@openib.org, openib-general@openib.org,
	raisch@de.ibm.com
References: <200701172312.14840.hnguyen@linux.vnet.ibm.com> <adavej4b1vi.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adavej4b1vi.fsf@cisco.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 10:56:01AM -0800, Roland Dreier wrote:
> I've kind of lost the plot here.  How does this patch fit in with the
> previous series of patches you posted?  Does it replace them or go on
> top of them?

It's a cleanup ontop of the actual fix.

