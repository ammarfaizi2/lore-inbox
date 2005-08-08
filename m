Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVHHWAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVHHWAI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbVHHWAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:00:08 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:23312 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932282AbVHHWAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:00:07 -0400
Date: Mon, 8 Aug 2005 17:59:21 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: greg@kroah.com, torvalds@osdl.org, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org, linville@redhat.com
Subject: Re: pci_update_resource() getting called on sparc64
Message-ID: <20050808215920.GA9387@tuxdriver.com>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>, greg@kroah.com,
	torvalds@osdl.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, linville@redhat.com
References: <20050808.123209.59463259.davem@davemloft.net> <20050808194249.GA6729@kroah.com> <20050808213842.GA9010@tuxdriver.com> <20050808.144347.78712074.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808.144347.78712074.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 02:43:47PM -0700, David S. Miller wrote:
> From: "John W. Linville" <linville@tuxdriver.com>
> Date: Mon, 8 Aug 2005 17:38:43 -0400
> 
> > So, w/ Dave's patch for Sparc64 to use setup-res.c, does the patch
> > stay?  Is there anything else I need to do?
> 
> The plan is to revert your patch for 2.6.13, and then put it
> back in with my (invasive at this point in the 2.6.13 development
> cycle) sparc64 patch on top.

Cool...thanks for clarifying!

Let me know if I can be helpful...

John
-- 
John W. Linville
linville@tuxdriver.com
