Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWD0Tu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWD0Tu2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 15:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWD0Tu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 15:50:27 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:29657
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750754AbWD0Tu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 15:50:27 -0400
Date: Thu, 27 Apr 2006 12:50:25 -0700 (PDT)
Message-Id: <20060427.125025.39345603.davem@davemloft.net>
To: jan.kiszka@googlemail.com
Cc: simlo@phys.au.dk, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: Van Jacobson's net channels and real-time
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <58d0dbf10604270300s6b6d2e1dg54bcd8ad2d3a1571@mail.gmail.com>
References: <58d0dbf10604270109j13ba5208h78f9b4de891370a8@mail.gmail.com>
	<20060427.011646.41961134.davem@davemloft.net>
	<58d0dbf10604270300s6b6d2e1dg54bcd8ad2d3a1571@mail.gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jan Kiszka" <jan.kiszka@googlemail.com>
Date: Thu, 27 Apr 2006 12:00:53 +0200

> Sorry that you had to remind of the different primary goals. I think
> we may look for something pluggable to support both large-scale rule
> tables as well as small ones for embedded RT-systems.

Even for such objectives, very specific understanding exists
in the algorithmic community for what is known to work best
for various kinds of packet classification.
