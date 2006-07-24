Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWGXMbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWGXMbW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 08:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWGXMbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 08:31:22 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:55939 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932131AbWGXMbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 08:31:21 -0400
Subject: Re: [PATCH] Add maintainer for memory management
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org
In-Reply-To: <200607241413.52064.ak@suse.de>
References: <1153713707.4002.43.camel@localhost.localdomain>
	 <200607241413.52064.ak@suse.de>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 08:31:03 -0400
Message-Id: <1153744263.4002.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-24 at 14:13 +0200, Andi Kleen wrote:
> > Note: If someone else is more likely the person than Christoph, don't be
> > offended that I didn't choose you.  It's just that Christoph has
> > responded the most whenever I mention anything about memory. So I chose
> > that as my criteria, than looking at who submits the most memory
> > patches.
> 	
> You can't just someone give a maintainer job until they agree first.
> Adding just the mailing list without "maintained" should be ok though.

You're right, and I probably went about it wrong.  I had no intention of
putting Christoph in the spot, but I figured this would bring attention
to MM missing from maintainers list.  I was just going to add the
linux-mm list without a maintainer, but I thought that alone wouldn't
still get a maintainer.

OK, is there an actual maintainer for the mm code?  Andrew Morton might
be the best person to ask this to.  Perhaps if someone would like the
job and that person is capable, we can choose an official maintainer for
the mm part of the kernel.

-- Steve

P.S. I once referred to anyone working in MM as a sadomasochist, and
that was because to work in the world of memory management, one must
really enjoy pain. So I can see if no one actually would want the title
of the MM maintainer. Would just the linux-mm be good enough for now?

