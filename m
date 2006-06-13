Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWFMUbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWFMUbm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWFMUbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:31:41 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:27788 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932163AbWFMUbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:31:40 -0400
Date: Tue, 13 Jun 2006 16:31:08 -0400
To: David Woodhouse <dwmw2@infradead.org>
Cc: Auke Kok <sofar@foo-projects.org>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Message-ID: <20060613203108.GE560@csclub.uwaterloo.ca>
References: <200606130300.k5D302rc004233@laptop11.inf.utfsm.cl> <1150189506.11159.93.camel@shinybook.infradead.org> <20060613104557.GA13597@merlin.emma.line.org> <1150201475.12423.12.camel@hades.cambridge.redhat.com> <20060613124944.GA16171@merlin.emma.line.org> <448ED798.2080706@perkel.com> <448EE057.6010101@foo-projects.org> <1150228444.11159.101.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150228444.11159.101.camel@shinybook.infradead.org>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2006 at 08:54:03PM +0100, David Woodhouse wrote:
> On Tue, 2006-06-13 at 08:57 -0700, Auke Kok wrote:
> > and this will also get you blacklisted - it is not allowed to have non-working 
> > or bogus MX records. See http://www.rfc-ignorant.org/policy-bogusmx.php 
> 
> Just set it to an IPv6-only host; that'll have the same effect on most
> of the Luddites out there without being invalid.

That particular site did explictly state that they treat ipv6 only hosts
the same as invalid hosts.  So not much point doing that either, unless
you like being blacklisted.

Len Sorensen
