Return-Path: <linux-kernel-owner+w=401wt.eu-S1751433AbXAKTWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbXAKTWd (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbXAKTWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:22:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43016 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbXAKTWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:22:32 -0500
Date: Thu, 11 Jan 2007 19:22:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org,
       raisch@de.ibm.com
Subject: Re: [PATCH/RFC 2.6.21 1/5] ehca: declaration of queue structures
Message-ID: <20070111192229.GD24623@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <rdreier@cisco.com>,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	openfabrics-ewg@openib.org, openib-general@openib.org,
	raisch@de.ibm.com
References: <200701112007.49620.hnguyen@linux.vnet.ibm.com> <20070111191425.GA24623@infradead.org> <adaac0pl6f2.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adaac0pl6f2.fsf@cisco.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 11:17:21AM -0800, Roland Dreier wrote:
>  > This indentation changes moves away from the preffered form.
> 
> I will fix when I merge it -- no need to resend.
> 
>  > Except for that the patch looks fine.
> 
> Christoph, did you look over all 5 or just this one so far?

I've looked over all briefly, but I need a few more minutes to understand
everything that's going on in patch 2.
