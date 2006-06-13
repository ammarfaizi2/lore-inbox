Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWFMUsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWFMUsl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWFMUsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:48:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1503 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932233AbWFMUsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:48:40 -0400
Subject: Re: VGER does gradual SPF activation (FAQ matter)
From: David Woodhouse <dwmw2@infradead.org>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Auke Kok <sofar@foo-projects.org>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060613203108.GE560@csclub.uwaterloo.ca>
References: <200606130300.k5D302rc004233@laptop11.inf.utfsm.cl>
	 <1150189506.11159.93.camel@shinybook.infradead.org>
	 <20060613104557.GA13597@merlin.emma.line.org>
	 <1150201475.12423.12.camel@hades.cambridge.redhat.com>
	 <20060613124944.GA16171@merlin.emma.line.org> <448ED798.2080706@perkel.com>
	 <448EE057.6010101@foo-projects.org>
	 <1150228444.11159.101.camel@shinybook.infradead.org>
	 <20060613203108.GE560@csclub.uwaterloo.ca>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 21:48:57 +0100
Message-Id: <1150231737.11159.118.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 16:31 -0400, Lennart Sorensen wrote:
> On Tue, Jun 13, 2006 at 08:54:03PM +0100, David Woodhouse wrote:
> > On Tue, 2006-06-13 at 08:57 -0700, Auke Kok wrote:
> > > and this will also get you blacklisted - it is not allowed to have non-working 
> > > or bogus MX records. See http://www.rfc-ignorant.org/policy-bogusmx.php 
> > 
> > Just set it to an IPv6-only host; that'll have the same effect on most
> > of the Luddites out there without being invalid.
> 
> That particular site did explictly state that they treat ipv6 only hosts
> the same as invalid hosts.  So not much point doing that either, unless
> you like being blacklisted.

Oh, in that case, it can just get dumped in the pile of other
kook-blacklists and we don't need to worry about it.

Shame; I didn't realise RFC-ignorant.org was so, well, ignorant.

-- 
dwmw2

