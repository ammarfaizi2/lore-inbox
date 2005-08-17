Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbVHQSog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbVHQSog (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 14:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVHQSog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 14:44:36 -0400
Received: from dsl027-180-204.sfo1.dsl.speakeasy.net ([216.27.180.204]:17793
	"EHLO outer-richmond.davemloft.net") by vger.kernel.org with ESMTP
	id S1751179AbVHQSof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 14:44:35 -0400
Date: Wed, 17 Aug 2005 11:39:30 -0700 (PDT)
Message-Id: <20050817.113930.06359944.davem@davemloft.net>
To: shaoran.85@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Atheros and rt2x00 driver
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1124298943.22673.11.camel@gentoo.lan>
References: <1124298943.22673.11.camel@gentoo.lan>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Jahren <shaoran.85@gmail.com>
Date: Wed, 17 Aug 2005 19:15:43 +0200

> Hello, I'm new to the mailling list, and couldn't find any traces of
> discussing this anywhere. I was wondering why neither the atheros driver
> http://madwifi.sourceforge.net, or the rt2x00 driver
> http://rt2x00.serialmonkey.com/wiki/index.php/Main_Page is included in
> the kernel?

Because the Atheros driver has binary-only components.
