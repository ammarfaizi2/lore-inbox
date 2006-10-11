Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161528AbWJKVlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161528AbWJKVlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161527AbWJKVlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:41:40 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11734
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161523AbWJKVli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:41:38 -0400
Date: Wed, 11 Oct 2006 14:41:37 -0700 (PDT)
Message-Id: <20061011.144137.18281355.davem@davemloft.net>
To: mst@mellanox.co.il
Cc: shemminger@osdl.org, steve@chygwyn.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org, rolandd@cisco.com
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061011212339.GH15468@mellanox.co.il>
References: <20061011135720.303f166b@freekitty>
	<20061011212339.GH15468@mellanox.co.il>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Date: Wed, 11 Oct 2006 23:23:39 +0200

> With my patch, there is a huge performance gain by increasing MTU to 64K.
> And it seems the only way to do this is by S/G.

Numbers?
