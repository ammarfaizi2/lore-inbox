Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVGWKuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVGWKuh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 06:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVGWKuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 06:50:35 -0400
Received: from mail1.kontent.de ([81.88.34.36]:23442 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261657AbVGWKud convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 06:50:33 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Kernel cached memory
Date: Sat, 23 Jul 2005 12:50:53 +0200
User-Agent: KMail/1.8
Cc: lgb@lgb.hu, Ashley <ashleyz@alchip.com>, linux-kernel@vger.kernel.org
References: <003401c58ea2$4dfd76f0$5601010a@ashley> <20050722132523.GJ20995@vega.lgb.hu> <1122055139.877.9.camel@mindpipe>
In-Reply-To: <1122055139.877.9.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200507231250.53562.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 22. Juli 2005 19:58 schrieb Lee Revell:
> On Fri, 2005-07-22 at 15:25 +0200, Gábor Lénárt wrote:
> > Anyway, want to have 'free memory' is a thing like having dozens of cars
> > in your garage which don't want to be used ...
> > 
> 
> Really?  I thought it was good to leave some memory free to speed up
> application startup, so we don't have to evict a bunch of pages first.

Eviction is cheap when the pages are clean.

	Regards
		Oliver
