Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272375AbTHECav (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 22:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272376AbTHECav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 22:30:51 -0400
Received: from almesberger.net ([63.105.73.239]:45830 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S272375AbTHECau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 22:30:50 -0400
Date: Mon, 4 Aug 2003 23:30:27 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Larry McVoy <lm@work.bitmover.com>,
       David Lang <david.lang@digitalinsight.com>,
       "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TOE brain dump
Message-ID: <20030804233026.R5798@almesberger.net>
References: <20030804223800.P5798@almesberger.net> <Pine.LNX.4.44.0308041841190.7534-100000@dlang.diginsite.com> <20030805015401.GA15811@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805015401.GA15811@work.bitmover.com>; from lm@bitmover.com on Mon, Aug 04, 2003 at 06:54:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> I'd suggest that all of you look at the fact that all of these offload 
> card companies have ended up dieing.  I don't know of a single one that
> made it to profitability.  Doesn't that tell you something?  What has 
> changed that makes this a good idea?

1) So far, most of the battle has been about data transfers.
   Now, per-packet overhead is becoming an issue.

2) AFAIK, they all went for designs that isolated their code
   from the main stack. That's one thing that, IMHO, has to
   change.

Is this enough to make TOE succeed ? I don't know.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
