Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWJJEi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWJJEi6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 00:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWJJEi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 00:38:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31386
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964967AbWJJEi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 00:38:57 -0400
Date: Mon, 09 Oct 2006 21:38:56 -0700 (PDT)
Message-Id: <20061009.213856.28787525.davem@davemloft.net>
To: joro-lkml@zlug.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 01/02 V2] net/ipv6: seperate sit driver to extra module
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061009093416.GA11901@zlug.org>
References: <20061009093416.GA11901@zlug.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <joro-lkml@zlug.org>
Date: Mon, 9 Oct 2006 11:34:16 +0200

> This is the changed version of the patch making the sit driver
> configurable as a seperate module.
> 
> Changes:
> - spelling fixes in Kconfig
> - changed "If unsure, say N" to "If unsure, say Y" for consistency

Joerg, when you make resubmissions, please always restate the full
changelog and all signed-off-by lines.

If you want to say "Changed since last version" do that seperately
at the top of the email, right before the main changelog entry and
the patch itself.

I wanted to apply this latest version of these two patches, but I
cannot because the full changelog isn't here.  Please get this
into a mergable form for me.

Thanks a lot.

