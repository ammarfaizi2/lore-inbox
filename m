Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVGHJpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVGHJpq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 05:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVGHJpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 05:45:46 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:9881 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262401AbVGHJpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 05:45:44 -0400
Date: Fri, 8 Jul 2005 13:45:30 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Tero Roponen <teanropo@cc.jyu.fi>
Cc: Jon Smirl <jonsmirl@gmail.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [SOLVED] Re: 2.6.13-rc2 hangs at boot
Message-ID: <20050708134530.A9262@jurassic.park.msu.ru>
References: <20050707135928.A3314@jurassic.park.msu.ru> <Pine.GSO.4.58.0507071324560.26776@tukki.cc.jyu.fi> <20050707163140.A4006@jurassic.park.msu.ru> <Pine.GSO.4.58.0507071546560.29406@tukki.cc.jyu.fi> <20050707174158.A4318@jurassic.park.msu.ru> <Pine.GSO.4.58.0507071709170.697@tukki.cc.jyu.fi> <20050708102852.B612@den.park.msu.ru> <Pine.GSO.4.58.0507081057001.8935@tukki.cc.jyu.fi> <20050708131914.B8779@jurassic.park.msu.ru> <Pine.GSO.4.58.0507081237140.10315@tukki.cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.58.0507081237140.10315@tukki.cc.jyu.fi>; from teanropo@cc.jyu.fi on Fri, Jul 08, 2005 at 12:38:28PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 12:38:28PM +0300, Tero Roponen wrote:
> > #define CARDBUS_IO_SIZE		(256)
> > #define CARDBUS_MEM_SIZE	(32*1024*1024)
> 
> This works correctly.

Thanks a lot. I'll go read the cardbus spec.

Ivan.
