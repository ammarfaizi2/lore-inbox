Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbVIZVzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbVIZVzV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 17:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVIZVzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 17:55:20 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50578
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932325AbVIZVzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 17:55:20 -0400
Date: Mon, 26 Sep 2005 14:55:17 -0700 (PDT)
Message-Id: <20050926.145517.02670662.davem@davemloft.net>
To: ecashin@coraid.com
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, jmacbaine@gmail.com
Subject: Re: [PATCH 2.6.14-rc2] aoe [2/2]: use get_unaligned for possibly
 unaligned accesses in ATA id buffer
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <87ll1jg4lt.fsf@coraid.com>
References: <87oe6fhj8y.fsf@coraid.com>
	<87ll1jg4lt.fsf@coraid.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ed L. Cashin" <ecashin@coraid.com>
Date: Mon, 26 Sep 2005 12:45:34 -0400

> Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
> 
> Use get_unaligned for possibly-unaligned multi-byte accesses to the
> ATA device identify response buffer.

Thanks for following up on this Ed.

Signed-off-by: David S. Miller <davem@davemloft.net>
