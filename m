Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTIRJEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 05:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbTIRJEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 05:04:09 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:56777 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262074AbTIRJEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 05:04:07 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Dani=EBl?= Mantione <daniel@deadlock.et.tudelft.nl>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       James Simmons <jsimmons@infradead.org>
In-Reply-To: <Pine.LNX.4.44.0309180940460.17499-100000@deadlock.et.tudelft.nl>
References: <Pine.LNX.4.44.0309180940460.17499-100000@deadlock.et.tudelft.nl>
Message-Id: <1063875815.600.238.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 18 Sep 2003 11:03:36 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: Patch: Make iBook1 work again
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-18 at 10:00, Daniël Mantione wrote:
> On Wed, 17 Sep 2003, Daniël Mantione wrote:
> 
> > So, to fix this we can look at the X driver, I must have made an error
> > somewhere.
> 
> I found a problem, but it would mean that it was already broken before my
> patch.

Yes, that's weird as it did work before your patch... Anyway, I cannot test
until i'm back home tonight. I'll let you know.

Regards,
Ben.


