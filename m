Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUIZRmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUIZRmo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 13:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUIZRmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 13:42:44 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:49170 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261169AbUIZRml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 13:42:41 -0400
Date: Sun, 26 Sep 2004 18:42:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Olivier Galibert <galibert@pobox.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: __initcall macros and C token pasting
Message-ID: <20040926184233.A18891@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tonnerre <tonnerre@thundrix.ch>,
	Olivier Galibert <galibert@pobox.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e47339104092510574c908525@mail.gmail.com> <20040925183234.GU23987@parcelfarce.linux.theplanet.co.uk> <9e473391040925121774e7e1e1@mail.gmail.com> <20040926172104.GA44528@dspnet.fr.eu.org> <20040926172429.GA15441@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040926172429.GA15441@thundrix.ch>; from tonnerre@thundrix.ch on Sun, Sep 26, 2004 at 07:24:29PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2004 at 07:24:29PM +0200, Tonnerre wrote:
> Actually, lots  of drivers  that *are* in  the kernel are  pretty much
> broken.

Sure.  OTOH you can count the non-broken drivers outside the kernel tree
with your fingers..

> And I don't  think putting more drivers into  the mainline kernel will
> fix this problem.

Actually it does.  It keeps them uptodate on API changes, and more important
gets them additional review.

