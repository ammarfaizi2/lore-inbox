Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbWHOFZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbWHOFZE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 01:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWHOFZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 01:25:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:46251
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965087AbWHOFZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 01:25:02 -0400
Date: Mon, 14 Aug 2006 22:25:04 -0700 (PDT)
Message-Id: <20060814.222504.61951856.davem@davemloft.net>
To: udovdh@xs4all.nl
Cc: linux-kernel@vger.kernel.org, folkert@vanheusden.com
Subject: Re: And another Oops / BUG? (2.6.17.7 on VIA Epia CL6000)
From: David Miller <davem@davemloft.net>
In-Reply-To: <44E139CD.3080103@xs4all.nl>
References: <44E096B4.9090207@xs4all.nl>
	<20060814.130814.126764626.davem@davemloft.net>
	<44E139CD.3080103@xs4all.nl>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Udo van den Heuvel <udovdh@xs4all.nl>
Date: Tue, 15 Aug 2006 05:04:45 +0200

> pptpd is needed for my adsl connection.
> pppd runs over it.
> it is not part of the kernel.

Oh yes it does, the pptp source file was mentioned by the kernel OOPS
message.  How did it get there if it's not part of the kernel? :)

