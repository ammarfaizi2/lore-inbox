Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVDJLzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVDJLzq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 07:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVDJLzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 07:55:46 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:3202 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261478AbVDJLzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 07:55:42 -0400
Date: Sun, 10 Apr 2005 15:54:43 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: johnpol@2ka.mipt.ru
Cc: Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, jmorris@redhat.com,
       ijc@hellion.org.uk, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, netdev@oss.sgi.com,
       jamal <hadi@cyberus.ca>
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Message-ID: <20050410155443.2d4fe469@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050410153757.104fe611@zanzibar.2ka.mipt.ru>
References: <1112942924.28858.234.camel@uganda>
	<E1DKZ7e-00070D-00@gondolin.me.apana.org.au>
	<20050410143205.18bff80d@zanzibar.2ka.mipt.ru>
	<1113131325.6994.66.camel@localhost.localdomain>
	<20050410153757.104fe611@zanzibar.2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Sun, 10 Apr 2005 15:54:44 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Apr 2005 15:37:57 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> The second one is a huge monster that can not be used in embedded
> systems, calling userspace process from inside the kernel is 
> now very flexible way.

is NOT very flexible way...


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
