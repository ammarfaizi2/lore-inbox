Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbVLVCj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbVLVCj5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 21:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbVLVCj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 21:39:57 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:26320
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965038AbVLVCj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 21:39:56 -0500
Date: Wed, 21 Dec 2005 18:39:59 -0800 (PST)
Message-Id: <20051221.183959.77486794.davem@davemloft.net>
To: mikukkon@iki.fi
Cc: vlan@candelatech.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VLAN: Add two missing checks to vlan_ioctl_handler()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051221205015.GC24213@localhost.localdomain>
References: <20051221205015.GC24213@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Kukkonen <mikukkon@iki.fi>
Date: Wed, 21 Dec 2005 22:50:15 +0200

> In vlan_ioctl_handler() the code misses couple checks for
> error return values.
> 
> Signed-of-by: Mika Kukkonen <mikukkon@iki.fi>

Looks good, applied, thanks.
