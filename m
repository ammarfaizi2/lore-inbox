Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268248AbUH2SJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268248AbUH2SJm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 14:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268250AbUH2SJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 14:09:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:33483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268248AbUH2SJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 14:09:39 -0400
Date: Sun, 29 Aug 2004 11:09:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Christoph Hellwig <hch@infradead.org>, Craig Milo Rogers <rogers@isi.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Termination of the Philips Webcam Driver (pwc)
In-Reply-To: <1093790181.27934.44.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0408291102010.2295@ppc970.osdl.org>
References: <20040826233244.GA1284@isi.edu>  <20040827004757.A26095@infradead.org>
  <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org>
 <1093790181.27934.44.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Aug 2004, Alan Cox wrote:
> 
> He is not sole author. Large parts of the code are based on other
> authors work and simply copied from the standard framework. Please put
> back the version without the hooks. It is useful to all sorts of people
> in that form.

Are you willing to stand up for that and be the maintainer for it?

I'm disgusted by how many people have been complaining, yet when I ask 
people to step up and actually _do_ something about it, people suddenly 
become very quiet, or continue complaining about it ignoring the 
fundamental issue.

Everybody (including you, Alan, so don't go hoity-toity on us) has
apparently totally ignored my calls for a new maintainer, and asking the 
people involved who wrote parts of the driver for their input. I quote an 
email from me:

	Date: Fri, 27 Aug 2004 11:13:09 -0700 (PDT)
	From: Linus Torvalds <torvalds@osdl.org>
	To: Xavier Bestel <xavier.bestel@free.fr>
	Cc: Christoph Hellwig <hch@infradead.org>,
	    Craig Milo Rogers <rogers@isi.edu>,
	    Kernel Mailing List <linux-kernel@vger.kernel.org>,
	    webcam@smcc.demon.nl
	Subject: Re: Termination of the Philips Webcam Driver (pwc)

	On Fri, 27 Aug 2004, Xavier Bestel wrote:
	> 
	> What if someone steps up and want to maintain and extend this piece of
	> code ? Will you forbid him (as in "not in my tree") ?

	I'd suggest you contact the people who have worked on that driver (there's 
	certainly people outside of nemosoft, at least according to the 
	changelogs) and see what they feel like and try to gauge how much they 
	were part of driver development. 

	...

I've got _lots_ of emails in my mailbox complaining.

I don't have a _single_ one actually responding for my calls to actually 
_do_ something about the driver.

Until people turn from whiners to doers, nothing will happen.

			Linus
