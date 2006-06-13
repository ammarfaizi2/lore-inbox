Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932955AbWFMHbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932955AbWFMHbf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 03:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932954AbWFMHbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 03:31:35 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:30910
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932948AbWFMHbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 03:31:34 -0400
Date: Tue, 13 Jun 2006 00:31:45 -0700 (PDT)
Message-Id: <20060613.003145.71163368.davem@davemloft.net>
To: hch@infradead.org
Cc: ak@suse.de, jeremy@goop.org, lkml@rtr.ca, mpm@selenic.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Using netconsole for debugging suspend/resume
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060613071819.GB16358@infradead.org>
References: <200606130654.14477.ak@suse.de>
	<20060612.220346.71553967.davem@davemloft.net>
	<20060613071819.GB16358@infradead.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@infradead.org>
Date: Tue, 13 Jun 2006 08:18:19 +0100

> That's actually not portable to certain arm platforms, but that's
> a different story.

Yes, cache issues :-/
