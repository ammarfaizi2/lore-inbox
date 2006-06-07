Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWFGU7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWFGU7f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 16:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWFGU7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 16:59:35 -0400
Received: from es335.com ([67.65.19.105]:31056 "EHLO mail.es335.com")
	by vger.kernel.org with ESMTP id S932410AbWFGU7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 16:59:34 -0400
Subject: Re: [PATCH v2 2/7] AMSO1100 WR / Event Definitions.
From: Steve Wise <swise@opengridcomputing.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: mshefty@ichips.intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org
In-Reply-To: <ada4pywg0ir.fsf@cisco.com>
References: <20060607200646.9259.24588.stgit@stevo-desktop>
	 <1149712762.27684.82.camel@stevo-desktop>  <ada4pywg0ir.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 15:59:32 -0500
Message-Id: <1149713972.27684.97.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-07 at 13:43 -0700, Roland Dreier wrote:
> I just realized it could be the spam filters.  You have some comments
> with three 'X's in a row which might be getting it blocked.  Is that
> possible?


There are other files that have comments with 'XXX' like c2_provider.c
and c2_qp.c which is in patch 3/7 and it made it though.  

These 'XXX' comments need to be cleaned up anyway, so I'll remove them
(or address the issue if there is one) and we'll see next time I post a
new version.

Steve.

