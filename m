Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272132AbTHRRQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 13:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272142AbTHRRQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 13:16:13 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:42703 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S272132AbTHRRQK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 13:16:10 -0400
Date: Mon, 18 Aug 2003 10:15:54 -0700
From: Larry McVoy <lm@bitmover.com>
To: John Bradford <john@grabjohn.com>
Cc: alan@lxorguk.ukuu.org.uk, torvalds@osdl.org, jamie@shareable.org,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] use simple_strtoul for unsigned kernel parameters
Message-ID: <20030818171554.GA32649@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	John Bradford <john@grabjohn.com>, alan@lxorguk.ukuu.org.uk,
	torvalds@osdl.org, jamie@shareable.org,
	linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
References: <200308181718.h7IHIUwU001800@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308181718.h7IHIUwU001800@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 06:18:30PM +0100, John Bradford wrote:
> Hmmm, at least some Cray machines require three-phase power, though,
> which is a problem for home use.

Huh?  You can get phase converters.  It's a common thing to do for home
shops with metal working tools.

But who cares?  Nobody is going to run a Cray in their home for more than
a few days, the power draw would get too expensive.  So this is well into
"angels in the head of a pin" land.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
