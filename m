Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTIRUYY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 16:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTIRUYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 16:24:24 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:50386 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262115AbTIRUYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 16:24:23 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Dani=EBl?= Mantione <daniel@deadlock.et.tudelft.nl>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       James Simmons <jsimmons@infradead.org>
In-Reply-To: <Pine.LNX.4.44.0309180940460.17499-100000@deadlock.et.tudelft.nl>
References: <Pine.LNX.4.44.0309180940460.17499-100000@deadlock.et.tudelft.nl>
Message-Id: <1063916627.603.5.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 18 Sep 2003 22:23:47 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: Patch: Make iBook1 work again
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The Mach64 LT does not have the M64F_FIFO_24 flag set! That will result in
> completely different values to be calculated and cause a distorted
> display.

I confirm, problem fixed ;)

Ben.


