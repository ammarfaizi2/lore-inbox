Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbVA0SJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbVA0SJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVA0SJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:09:44 -0500
Received: from canuck.infradead.org ([205.233.218.70]:4616 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262592AbVA0SJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:09:37 -0500
Subject: Re: Patch 4/6  randomize the stack pointer
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
In-Reply-To: <41F92D2B.4090302@comcast.net>
References: <20050127101117.GA9760@infradead.org>
	 <20050127101322.GE9760@infradead.org>  <41F92721.1030903@comcast.net>
	 <1106848051.5624.110.camel@laptopd505.fenrus.org>
	 <41F92D2B.4090302@comcast.net>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 19:09:31 +0100
Message-Id: <1106849371.5624.114.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-27 at 13:04 -0500, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> What the hell?
> 
> So instead of bringing something in that works, you bring something in
> that does significantly less, and gives no savings on overhead or patch
> complexity why?  So you can later come out and say "We're so great now
> we've increased the randomization by tweaking one variable aren't we
> cool!!!"?

no it is called getting features in via a long incremental and
debuggable patch series.
Apparently you still don't understand that despite the long flamewar in
that other thread. I can't think of any more I can do to explain to you
why doing things in incremental steps is good on top of that.

> 
> Red Hat is all smoke and mirrors anyway when it comes to security, just
> like Microsoft.  This just reaffirms that.

I think you've been talking too much to another so called security
expert that has been spouting similar words on full-disclosure recently.

And I have to wonder.. where does Red Hat come in here?


