Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVHDSQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVHDSQy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 14:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVHDSQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 14:16:54 -0400
Received: from palrel10.hp.com ([156.153.255.245]:60865 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262478AbVHDSQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 14:16:53 -0400
Date: Thu, 4 Aug 2005 11:20:16 -0700
From: Grant Grundler <iod00d@hp.com>
To: Roland Dreier <rolandd@cisco.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] [RFC] Move InfiniBand .h files
Message-ID: <20050804182016.GE20422@esmail.cup.hp.com>
References: <52iryla9r5.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52iryla9r5.fsf@cisco.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 10:32:14AM -0700, Roland Dreier wrote:
...
I agree with the rename/relocation of the header files for
the reasons you mentioned.

>   - It makes it a little harder to pull the OpenIB svn tree into a
>     kernel tree, since one would have to link both drivers/infiniband
>     and include/linux/rdma instead of just drivers/infiniband.  This
>     problem goes away if/when OpenIB shifts over to a new source code
>     control system.

Any thoughts on renaming drivers/infiniband to drivers/rdma
at the same time?

If you are going to churn...don't be shy about it :^)

grant
