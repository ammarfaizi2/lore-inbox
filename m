Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263960AbTIBSSG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263801AbTIBSSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:18:01 -0400
Received: from ascomax.hasler.ascom.ch ([139.79.135.1]:29082 "EHLO
	ascomax.hasler.ascom.ch") by vger.kernel.org with ESMTP
	id S264069AbTIBSRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:17:44 -0400
Date: Tue, 2 Sep 2003 20:16:54 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       andrew@lunn.ch, linux-kernel@vger.kernel.org, andrew.lunn@ascom.ch
Subject: Re: 2.6-test4 Traditional pty and devfs
Message-ID: <20030902181654.GB6652@biferten.ma.tech.ascom.ch>
References: <20030902104212.GA23978@londo.lunn.ch> <20030902150808.A7388@infradead.org> <20030902102141.44dc7297.akpm@osdl.org> <20030902184236.A14715@infradead.org> <20030902104340.1e360f1b.akpm@osdl.org> <20030902190258.A15601@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902190258.A15601@infradead.org>
User-Agent: Mutt/1.4i
X-Filter-Version: 1.11a (ascomax)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's why I'm really keen on knowing how the system of the bugreporter
> looks - this shouldn't happen without a very strange setup.

I've attached to the bugzilla bug my .config (its actually for -test2)
and an ls -la /dev/pt*

Is there anything else you want to know?

   Andrew
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
> That's why I'm really keen on knowing how the system of the bugreporter
> looks - this shouldn't happen without a very strange setup.

I've attached to the bugzilla bug my .config (its actually for -test2)
and an ls -la /dev/pt*

Is there anything else you want to know?

   Andrew
