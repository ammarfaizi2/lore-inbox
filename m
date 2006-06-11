Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWFKNDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWFKNDQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 09:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWFKNDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 09:03:16 -0400
Received: from thunk.org ([69.25.196.29]:38034 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751251AbWFKNDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 09:03:16 -0400
Date: Sun, 11 Jun 2006 09:02:49 -0400
From: Theodore Tso <tytso@mit.edu>
To: Rik van Riel <riel@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
Message-ID: <20060611130249.GA10606@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Rik van Riel <riel@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	linux-kernel@vger.kernel.org
References: <20060610222734.GZ27502@mea-ext.zmailer.org> <1149980791.18635.197.camel@shinybook.infradead.org> <Pine.LNX.4.64.0606102015410.30593@cuia.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606102015410.30593@cuia.boston.redhat.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 08:16:24PM -0400, Rik van Riel wrote:
> On Sun, 11 Jun 2006, David Woodhouse wrote:
> > On Sun, 2006-06-11 at 01:27 +0300, Matti Aarnio wrote:
> > > Now that there is even an RFC published about SPF...
> > 
> > Please, don't do this. SPF makes assumptions about email which are just
> > not true; it rejects perfectly valid mail.
> > 
> > http://david.woodhou.se/why-not-spf.html
> 
> Think about it for a second.  Do you *really* want those
> something@alumni.mit.edu people on lkml? :)

Actually, I post as "tytso@mit.edu" (but always relayed through my
mail relay at thunk.org).  :-)

						- Ted
