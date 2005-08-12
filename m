Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbVHLS36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVHLS36 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbVHLS36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:29:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27365
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750896AbVHLS35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:29:57 -0400
Date: Fri, 12 Aug 2005 11:29:54 -0700 (PDT)
Message-Id: <20050812.112954.115910063.davem@davemloft.net>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
       jdike@addtoit.com, bstroesser@fujitsu-siemens.com,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [RFC] [patch 0/39] remap_file_pages protection support, try 2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200508122033.06385.blaisorblade@yahoo.it>
References: <200508122033.06385.blaisorblade@yahoo.it>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please do not BOMB linux-kernel with 39 patches in one
go, that will kill the list server.

Try to consolidate your patch groups into smaller pieces,
like so about 10 or 15 at a time.  And send any that remain
on some later date.
