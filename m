Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbTLGVzI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbTLGVzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 16:55:08 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:7593 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S264582AbTLGVzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 16:55:03 -0500
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Additional clauses to GPL in network drivers
References: <200312071515.hB7FFkQH000866@81-2-122-30.bradfords.org.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 07 Dec 2003 17:15:30 +0100
In-Reply-To: <200312071515.hB7FFkQH000866@81-2-122-30.bradfords.org.uk> (John
 Bradford's message of "Sun, 7 Dec 2003 15:15:46 GMT")
Message-ID: <m3brqkioyl.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> writes:

> "This file is not a complete program and may only be used when the
> entire operating system is licensed under the GPL".
>
> as
> grep -C 1 "only be used when"
>
> in drivers/net will confirm.
>
> *Please*, can we resist the temptation to 'play' with licenses in this
> way?  I suspect this extra clause was added just to clarify what the
> GPL already says,

I don't think so - GPL doesn't restrict the _use_, only the distribution.

I.e. I'd be breaking law by merely _using_ the epic100 driver, as the
operating system (my experimental Linux-based system) isn't licensed
under GPL - in fact, it isn't licensed under any license, as I don't
distribute it at all.
-- 
Krzysztof Halasa, B*FH
