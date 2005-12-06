Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751627AbVLFESe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbVLFESe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 23:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbVLFESe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 23:18:34 -0500
Received: from sanosuke.troilus.org ([66.92.173.88]:62150 "EHLO
	sanosuke.troilus.org") by vger.kernel.org with ESMTP
	id S1751627AbVLFESb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 23:18:31 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	<200512051826.06703.andrew@walrond.org>
	<1133817575.11280.18.camel@localhost.localdomain>
	<1133817888.9356.78.camel@laptopd505.fenrus.org>
	<1133819684.11280.38.camel@localhost.localdomain>
	<4394D396.1020102@am.sony.com> <20051206041215.GC26602@kroah.com>
From: Michael Poole <mdpoole@troilus.org>
Date: 05 Dec 2005 23:18:15 -0500
In-Reply-To: <20051206041215.GC26602@kroah.com>
Message-ID: <87iru2c0zc.fsf@graviton.dyn.troilus.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Mon, Dec 05, 2005 at 03:56:06PM -0800, Tim Bird wrote:
> > DISCLAIMER: I'm not speaking for Sony here. Personally
> > I don't believe that most drivers are derivative works
> > of the operating systems they run with, and I don't
> > believe it helps Linux to assert that they are.
> > But, hey, it's not my kernel, and not my plan for
> > world domination. ;-)
> 
> Why do people bring up the "derivative works" issue all the time.  Are
> they so blind to the very simple "linking" issue that all kernel modules
> do when they are loaded into the kernel?

Most likely people bring up the "derivative works" issue because
that's what the GPL says it affects.  The FSF contends that linking
creates a derivative work, but is curiously quiet when people ask for
statutory or case law to support that claim.

Besides, if the act of linking is what makes the derivative work,
there is no problem: The GPL allows a user to make any modifications
or combinations or derivatives whatsoever, and only imposes
requirements when the result is distributed.  The linking of the two
works occurs only on the end user's machine.

Michael Poole
