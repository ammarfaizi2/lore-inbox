Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751621AbWJMEWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWJMEWj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 00:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbWJMEWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 00:22:39 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:43701
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751620AbWJMEWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 00:22:38 -0400
Date: Thu, 12 Oct 2006 21:22:40 -0700 (PDT)
Message-Id: <20061012.212240.26278742.davem@davemloft.net>
To: mst@mellanox.co.il
Cc: shemminger@osdl.org, steve@chygwyn.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org, rolandd@cisco.com
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061012191206.GA16516@mellanox.co.il>
References: <20061011.144137.18281355.davem@davemloft.net>
	<20061012191206.GA16516@mellanox.co.il>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Date: Thu, 12 Oct 2006 21:12:06 +0200

> Quoting r. David Miller <davem@davemloft.net>:
> > Subject: Re: Dropping NETIF_F_SG since no checksum feature.
> > 
> > Numbers?
> 
> I created two subnets on top of the same pair infiniband HCAs:

I was asking for SG vs. non-SG numbers so I could see proof
that it really does help like you say it will.
