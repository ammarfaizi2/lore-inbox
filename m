Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267615AbUH3JfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267615AbUH3JfW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 05:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267619AbUH3JfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 05:35:22 -0400
Received: from jib.isi.edu ([128.9.128.193]:33419 "EHLO jib.isi.edu")
	by vger.kernel.org with ESMTP id S267615AbUH3JfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 05:35:15 -0400
Date: Mon, 30 Aug 2004 02:35:02 -0700
From: Craig Milo Rogers <rogers@isi.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Termination of the Philips Webcam Driver (pwc)
Message-ID: <20040830093502.GB32665@isi.edu>
References: <20040826233244.GA1284@isi.edu> <20040827004757.A26095@infradead.org> <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org> <1093790181.27934.44.camel@localhost.localdomain> <Pine.LNX.4.58.0408291102010.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408291102010.2295@ppc970.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.29, Linus Torvalds wrote:
> I'm disgusted by how many people have been complaining, yet when I ask 
> people to step up and actually _do_ something about it, people suddenly 
> become very quiet, or continue complaining about it ignoring the 
> fundamental issue.
> 
> Everybody (including you, Alan, so don't go hoity-toity on us) has
> apparently totally ignored my calls for a new maintainer, and asking the 
> people involved who wrote parts of the driver for their input.
...
> I don't have a _single_ one actually responding for my calls to actually 
> _do_ something about the driver.

	I beg your pardon, but that is not true.  I volunteered to be
a maintainer of the open-source pwc driver in one of my messages of
the 27th.  Quote:

    So long as someone is available to maintain the closed-source
    codecs (while, we all hope, working in parallel with the manufacturers
    involved to secure open-source licensing for any currently
    closed-source components), I am confident that we can put together
    a team to implement the rest. I would be pleased to be on the team.

	I then submitted an overall design for a revised open-source
driver, and a graceful transition plan.  Please see my message
entitled: "PWC: A Plea for Grace" for details.

	I've discussed some of my proposal for maintenance pf pwc with
Nemosoft offline (apparently, I'm not the only one discussing pwc
maintenance with Nemosoft offline), and received what I believe is a
favorable response.

					Craig Milo Rogers
