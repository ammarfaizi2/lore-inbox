Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVAHQti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVAHQti (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 11:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVAHQti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 11:49:38 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:7620 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261211AbVAHQtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 11:49:36 -0500
Subject: Re: starting with 2.7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41DEC83D.30105@comcast.net>
References: <1105096053.5444.11.camel@ulysse.olympe.o2t>
	 <20050107111508.GA6667@infradead.org> <20050107111751.GA6765@infradead.org>
	 <41DEC83D.30105@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105196469.10519.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 08 Jan 2005 15:45:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-07 at 17:34, John Richard Moser wrote:
> My scheme involved a 6 month release cycle supporting kernels with
> bugfixes for the prior 18 months (3 releases), though if you're really
> committed to hardware driver backporting, I guess it can be done in the
> actiwve "Stable" branch.

18 months is as good as supporting a seperate product line. Also you
forgot to provide the engineering resources for your plan and to fund
them 8)

> to load up maintainers with a billion hours of backporting; but I don't
> want to load distributors with excess work either.

Distributors get paid by their customers to do the long term backporting
and careful change control for big business. We take it as given that
its -our- problem not the software developers.


