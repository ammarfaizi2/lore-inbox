Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVG0Vih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVG0Vih (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 17:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVG0V2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 17:28:16 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:26525
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262459AbVG0V1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 17:27:23 -0400
Date: Wed, 27 Jul 2005 14:27:21 -0700 (PDT)
Message-Id: <20050727.142721.111207564.davem@davemloft.net>
To: akpm@osdl.org
Cc: andrew.j.wade@gmail.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050727141151.4a97843f.akpm@osdl.org>
References: <20050727024330.78ee32c2.akpm@osdl.org>
	<200507271648.52745.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
	<20050727141151.4a97843f.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Wed, 27 Jul 2005 14:11:51 -0700

> Unbalanced netlink_table_ungrab() in the netlink stuff in git-net.patch.

Applied to net-2.6.14, thanks Andrew.
