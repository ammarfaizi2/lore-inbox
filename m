Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVA2Rz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVA2Rz5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 12:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVA2Rz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 12:55:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45706 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261526AbVA2Rzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 12:55:52 -0500
Date: Sat, 29 Jan 2005 17:55:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Jakub Jelinek <jakub@redhat.com>, Rik van Riel <riel@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
Message-ID: <20050129175549.GA2846@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	John Richard Moser <nigelenki@comcast.net>,
	Jakub Jelinek <jakub@redhat.com>, Rik van Riel <riel@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1106848051.5624.110.camel@laptopd505.fenrus.org> <41F92D2B.4090302@comcast.net> <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org> <41F95F79.6080904@comcast.net> <1106862801.5624.145.camel@laptopd505.fenrus.org> <41F96C7D.9000506@comcast.net> <Pine.LNX.4.61.0501282147090.19494@chimarrao.boston.redhat.com> <41FB2DD2.1070405@comcast.net> <20050129173704.GM11199@devserv.devel.redhat.com> <41FBCC91.8010602@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FBCC91.8010602@comcast.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 12:49:05PM -0500, John Richard Moser wrote:
> > The ideas in IBM's ProPolice changes are good and worth
> > implementing, but the current implementation is bad.
> > 
> 
> Lies.  I've read the paper on the current implementation, it's
> definitely good.  It only operates on C/C++ code though, but that's the
> scope of it.

Yeah, I guess your extensive compiler internals experience and knowledge
of gcc internals weights a lot more than the opinion of the gcc team..

