Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWDKWVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWDKWVn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWDKWVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:21:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:23683 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751163AbWDKWVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:21:41 -0400
Subject: Re: [RFC/PATCH] remove unneeded check in bcm43xx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: benoit.boissinot@ens-lyon.org, mb@bu3sch.de, netdev@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       linville@tuxdriver.com
In-Reply-To: <20060411.143407.74615246.davem@davemloft.net>
References: <1144719972.19353.24.camel@localhost.localdomain>
	 <20060410.224933.39567033.davem@davemloft.net>
	 <1144788541.19353.41.camel@localhost.localdomain>
	 <20060411.143407.74615246.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 08:21:17 +1000
Message-Id: <1144794077.19353.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I still think we shouldn't reward shit hardware by complicating
> up our DMA mappings internals. :-)

BTW. In the meantime, can't that driver work in PIO only mode ?

Ben.


