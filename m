Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422850AbWKEXrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422850AbWKEXrL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 18:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422840AbWKEXrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 18:47:10 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31166
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932750AbWKEXrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 18:47:09 -0500
Date: Sun, 05 Nov 2006 15:47:17 -0800 (PST)
Message-Id: <20061105.154717.90121153.davem@davemloft.net>
To: kaber@trash.net
Cc: joro-lkml@zlug.org, jdi@l4x.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/02 V3] net/ipv6: seperate sit driver to extra module
From: David Miller <davem@davemloft.net>
In-Reply-To: <454E75E6.7010500@trash.net>
References: <454E671B.2090302@trash.net>
	<20061105.152718.88476049.davem@davemloft.net>
	<454E75E6.7010500@trash.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy <kaber@trash.net>
Date: Mon, 06 Nov 2006 00:38:14 +0100

> David Miller wrote:
> > Would you like me to apply this or is this a temp workaround
> > for folks?
> 
> Please apply it. I usually build things as module if possible,
> which in this case caused my tunnel to break. This will
> probably happen to others as well.

Ok, done.

Thanks.
