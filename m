Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992536AbWJTHQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992536AbWJTHQd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992537AbWJTHQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:16:33 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59606
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S2992536AbWJTHQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:16:32 -0400
Date: Fri, 20 Oct 2006 00:16:34 -0700 (PDT)
Message-Id: <20061020.001634.95507106.davem@davemloft.net>
To: akpm@osdl.org
Cc: shemminger@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] netpoll/netconsole fixes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061019235719.5b30c5d3.akpm@osdl.org>
References: <20061019171541.062261760@osdl.org>
	<20061019235719.5b30c5d3.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Thu, 19 Oct 2006 23:57:19 -0700

> I got a reject storm when applying the third patch then screwed it up
> rather than fixing it up.
> 
> A rediff and resend is needed, please.  Make sure it's against the latest
> -linus or -davem, thanks.

And I got rejects on #2 :-)

His first patch is in my net-2.6 tree as of a few minutes
ago, that one was fine.
