Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280824AbRKLTAy>; Mon, 12 Nov 2001 14:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280959AbRKLTAo>; Mon, 12 Nov 2001 14:00:44 -0500
Received: from 200-171-244-84.customer.telesp.net.br ([200.171.244.84]:17031
	"EHLO socrates.dnsalias.org") by vger.kernel.org with ESMTP
	id <S280956AbRKLTAl>; Mon, 12 Nov 2001 14:00:41 -0500
Date: Mon, 12 Nov 2001 17:00:26 -0200
To: Nils Philippsen <nils@wombat.dialup.fht-esslingen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VIA timer fix was removed?
Message-ID: <20011112170026.A7310@socrates>
In-Reply-To: <20011112111409.A2617@socrates> <200111121448.PAA01060@green.mif.pg.gda.pl> <20011112140530.A23866@socrates> <1005590954.23106.1.camel@wombat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1005590954.23106.1.camel@wombat>
User-Agent: Mutt/1.3.23i
From: Jeronimo Pellegrini <pellegrini@mpcnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have seen IBM machines (Netfinity 6000R) where this code got triggered
> even though they didn't have VIA chipsets/timers. Seems to have caused
> some problems there and I removed the code (in the custom kernel running
> on those machines).

#ifdefs and a question in config, maybe?

J.

-- 
