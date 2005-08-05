Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262928AbVHEJWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262928AbVHEJWc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 05:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbVHEJWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 05:22:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31156 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262931AbVHEJWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 05:22:31 -0400
Date: Fri, 5 Aug 2005 10:22:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Move InfiniBand .h files
Message-ID: <20050805092228.GA7237@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <rolandd@cisco.com>, openib-general@openib.org,
	linux-kernel@vger.kernel.org
References: <52iryla9r5.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52iryla9r5.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 10:32:14AM -0700, Roland Dreier wrote:
> I would like to get people's reactions to moving the InfiniBand .h
> files from their current location in drivers/infiniband/include/ to
> include/linux/rdma/.  If we agree that this is a good idea then I'll
> push this change as soon as 2.6.14 starts.

include/rmda, please.  not need for the linux/ component.

> 
> The advantages of doing this are:
> 
