Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbTIMRvv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 13:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbTIMRvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 13:51:51 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:9483 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262080AbTIMRvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 13:51:50 -0400
Date: Sat, 13 Sep 2003 10:34:12 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: David Schwartz <davids@webmaster.com>,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
Subject: Re: People, not GPL  [was: Re: Driver Model]
In-Reply-To: <m14qzjmp0d.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.10.10309131030590.16744-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Sep 2003, Eric W. Biederman wrote:

> "David Schwartz" <davids@webmaster.com> writes:
> 
> > 	The GPL_ONLY stuff is an attempt to restrict use. There is nothing
> > inherently wrong with attempts to restrict use. One could argue that the
> > root permission check on 'umount' is a restriction on use. Surely the GPL
> > doesn't mean you can't have any usage restrictions at all.
> 
> No the GPL_ONLY stuff is an attempt to document that there is no conceivable
> way that using a given symbol does not create a derived work.  

Bzzit ... GPL_ONLY stuff is an attempt to retrict usage by removing access
to the unprotectable API.  And for anyone claiming there is not API to
protect, the kernel source is the manual to the API.  The foolish intent
and design to hide the API has caused the kernel itself to become the
manual.

This is even obvious to people, like myself, who are not lawyers.

Andre

