Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753890AbWKFWgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890AbWKFWgv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753889AbWKFWgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:36:51 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:63897
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1753886AbWKFWgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:36:50 -0500
Date: Mon, 06 Nov 2006 14:36:49 -0800 (PST)
Message-Id: <20061106.143649.31640600.davem@davemloft.net>
To: jgarzik@pobox.com
Cc: jirislaby@gmail.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       alan@redhat.com, kaber@trash.net, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] Net: kconfig, correct traffic shaper
From: David Miller <davem@davemloft.net>
In-Reply-To: <454EE9A2.4060908@pobox.com>
References: <43123154321532@wsc.cz>
	<1202725131414221392@wsc.cz>
	<454EE9A2.4060908@pobox.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jgarzik@pobox.com>
Date: Mon, 06 Nov 2006 02:52:02 -0500

> ACK from me, though I think that since it relates to traffic schedulers 
> I think this patch should be merged through DaveM...

I've merged it into my tree, thanks everyone.
