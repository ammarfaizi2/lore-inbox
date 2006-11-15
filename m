Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966741AbWKOKY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966741AbWKOKY3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 05:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966742AbWKOKY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 05:24:29 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:38302 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S966741AbWKOKY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 05:24:28 -0500
Date: Wed, 15 Nov 2006 12:24:26 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Marc Perkel <mperkel@yahoo.com>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel list rejecting my email - braindead list
Message-ID: <20061115102426.GJ10054@mea-ext.zmailer.org>
References: <20061114.142349.74748158.davem@davemloft.net> <20061115005426.37928.qmail@web52505.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061115005426.37928.qmail@web52505.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 04:54:25PM -0800, Marc Perkel wrote:
> 
> So you are banning me from the list because my server
> returned a 421 temporary error? You have to be out of
> your fucking mind!
>
> 1136501663 davem marc@perkel.com linux-kernel 421 Lost incoming connection: The error was detected in line 3.

Messages start to BOUNCE with that only after the condition
has been active for 5 consequtive days.
(Standards define 3 days queue wait time minimum.)

If your email server has a temporary glitch and it does
decide to report to remotes that "421 I am broken, try latter"
that is fine AS LONG AS it gets fixed within 3 days.

If the condition persists for 5 days, we do remove all
subscribers at given domain AND the accumulated queue
to them without any further messages to anybody.
(They are not receiving the messages, so there is no way to
notify them in forecastable future.)

Do you have any idea of how many messages are in the queue
at that time directed to recipients not receiving them ?
Depending on the week: 1300 - 2000 !

  /Matti Aarnio  -- one of  <postmaster at vger.kernel.org>
