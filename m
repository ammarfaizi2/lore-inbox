Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVA2SRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVA2SRM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 13:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVA2SQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 13:16:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63626 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261363AbVA2SQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 13:16:36 -0500
Date: Sat, 29 Jan 2005 18:16:26 +0000
From: Christoph Hellwig <hch@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Jakub Jelinek <jakub@redhat.com>, Rik van Riel <riel@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
Message-ID: <20050129181626.GA3080@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	John Richard Moser <nigelenki@comcast.net>,
	Jakub Jelinek <jakub@redhat.com>, Rik van Riel <riel@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org> <41F95F79.6080904@comcast.net> <1106862801.5624.145.camel@laptopd505.fenrus.org> <41F96C7D.9000506@comcast.net> <Pine.LNX.4.61.0501282147090.19494@chimarrao.boston.redhat.com> <41FB2DD2.1070405@comcast.net> <20050129173704.GM11199@devserv.devel.redhat.com> <41FBCC91.8010602@comcast.net> <20050129175549.GA2846@infradead.org> <41FBD1AE.2080608@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FBD1AE.2080608@comcast.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 01:10:54PM -0500, John Richard Moser wrote:
> > Yeah, I guess your extensive compiler internals experience and knowledge
> > of gcc internals weights a lot more than the opinion of the gcc team..
> > 
> 
> I read "implementation" as "the way it's implemented," not as "the
> quality of the code."

Doesn't really matter, it'd fit for both.

> 
> Did I miss the target?  *Aims in the other direction then?*

Yes.  Try to search for propolice in the gcc mailglist archives
as a start.  Doing a little bit of research before calling someone
a liar is usually considered a good idea.

