Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265332AbTFFFzJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 01:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265334AbTFFFzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 01:55:08 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.92.226.153]:27084 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S265332AbTFFFzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 01:55:04 -0400
Date: Fri, 6 Jun 2003 02:08:35 -0400
From: Dan Maas <dmaas@maasdigital.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alpha hang after 24hrs (2.4.21-rc6)
Message-ID: <20030606020835.A25093@morpheus>
References: <20030605004557.A22504@morpheus> <20030605045626.GD10750@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030605045626.GD10750@alpha.home.local>; from willy@w.ods.org on Thu, Jun 05, 2003 at 06:56:26AM +0200
X-Info: http://www.maasdigital.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The system is a stock 1-CPU 500MHz Alpha, 128MB RAM, nothing
> > special, just two 3c59x ethernet cards and an AIC788x SCSI
> > controller.

> Mine has been running 2.4.21-rc3 + this driver for 8 days now
> without problem, and there's not much difference between -rc3 and
> -rc6.

Sorry, it didn't help. 2.4.21-rc6 with Gibbs' aic7xxx driver hung
after about 18 hrs, then again after ~1 hr.

I just loaded up 2.4.20 with Gibbs' driver. We'll see how this goes.

Dan
