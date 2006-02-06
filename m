Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWBGABE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWBGABE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWBGABD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:01:03 -0500
Received: from ns.firmix.at ([62.141.48.66]:59533 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932161AbWBGABB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:01:01 -0500
Subject: Re: Linux drivers management
From: Bernd Petrovitsch <bernd@firmix.at>
To: Yaroslav Rastrigin <yarick@it-territory.ru>
Cc: Joshua Kugler <joshua.kugler@uaf.edu>, linux-kernel@vger.kernel.org,
       Nicolas Mailhot <nicolas.mailhot@laposte.net>,
       David Chow <davidchow@shaolinmicro.com>
In-Reply-To: <200602062217.19697.yarick@it-territory.ru>
References: <1139250712.20009.20.camel@rousalka.dyndns.org>
	 <200602061002.27477.joshua.kugler@uaf.edu>
	 <200602062217.19697.yarick@it-territory.ru>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Tue, 07 Feb 2006 00:52:28 +0100
Message-Id: <1139269948.3583.25.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-06 at 22:17 +0300, Yaroslav Rastrigin wrote:
[...]
> All over the net ? Again, you're proving stable API/ABI supporters nicely. 

Not necessarily since there are other solutions like "submit the driver
into the kernel".
And exactly then you get the best of both worlds: The driver is "up to
date" and not even distributors have care (well, at least for almost all
of them).

> If kernel has stable ABI, basic/default driver is included on installation CD, and all you need to do 

Have fun done *doing* this.

> And what to do if you've bought new hardware, installed it and _voila_ - NO IN-TREE DRIVER exists ?
> Do you want every Linux user  going for shopping to nearest WalMart carry full linux hardware compatibility list printed out ?

It worked years ago that way. So what?

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services



