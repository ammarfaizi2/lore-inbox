Return-Path: <linux-kernel-owner+w=401wt.eu-S1754503AbWLRWOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503AbWLRWOO (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 17:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754685AbWLRWOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 17:14:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35795 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503AbWLRWON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 17:14:13 -0500
Date: Mon, 18 Dec 2006 22:14:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Linus Torvalds <torvalds@osdl.org>,
       Ricardo Galli <gallir@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
Message-ID: <20061218221400.GA25472@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alexandre Oliva <aoliva@redhat.com>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Ricardo Galli <gallir@gmail.com>, linux-kernel@vger.kernel.org
References: <200612161927.13860.gallir@gmail.com> <Pine.LNX.4.64.0612161253390.3479@woody.osdl.org> <orwt4qaara.fsf@redhat.com> <86C272DA-23BA-4901-994D-6CABCC87A2DE@mac.com> <orlkl56lgi.fsf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orlkl56lgi.fsf@redhat.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 05:41:17PM -0200, Alexandre Oliva wrote:
> On Dec 17, 2006, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> 
> > On the other hand, certain projects like OpenAFS, while not license- 
> > compatible, are certainly not derivative works.
> 
> Certainly a big chunk of OpenAFS might not be, just like a big chunk
> of other non-GPL drivers for Linux.
> 
> But what about the glue code?  Can that be defended as not a derived
> work, such that it doesn't have to be GPL?

Actually the OpenAFS kernel code almost 100% is a derived work of both
the original AFS codebase and Linux.  Just go and take a look at it,
there's shitloads of copy & paste and very deep poking into kernel internals.


