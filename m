Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVE0UlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVE0UlO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 16:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbVE0UlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 16:41:02 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11978
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262587AbVE0Ukw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 16:40:52 -0400
Date: Fri, 27 May 2005 13:40:32 -0700 (PDT)
Message-Id: <20050527.134032.78491984.davem@davemloft.net>
To: mchan@broadcom.com
Cc: linville@tuxdriver.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       jgarzik@pobox.com
Subject: Re: [patch 2.6.12-rc5] tg3: add bcm5752 entry to pci.ids
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1117221859.4310.6.camel@rh4>
References: <20050527184750.GB11592@tuxdriver.com>
	<20050527.123037.68041200.davem@davemloft.net>
	<1117221859.4310.6.camel@rh4>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael Chan" <mchan@broadcom.com>
Date: Fri, 27 May 2005 12:24:19 -0700

> So in the future, do we need to patch this file or just let sourceforge
> take care of it?

I think the proper procedure is to send it to sourceforge.
But there is some latency in the changes making it back
into the kernel.

Either way, if it is submitted to the kernel or sourceforge (or even
both), it ends up getting merged together in the end.
