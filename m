Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946207AbWJSQdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946207AbWJSQdo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946208AbWJSQdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:33:44 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7830 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946207AbWJSQdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:33:43 -0400
Subject: Re: [PATCH] Undeprecate the sysctl system call
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Cal Peake <cp@absolutedigital.net>, Andrew Morton <akpm@osdl.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m1irig5oli.fsf@ebiederm.dsl.xmission.com>
References: <453519EE.76E4.0078.0@novell.com>
	 <20061017091901.7193312a.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0610171401130.10587@lancer.cnet.absolutedigital.net>
	 <1161123096.5014.0.camel@localhost.localdomain>
	 <20061017150016.8dbad3c5.akpm@osdl.org>
	 <Pine.LNX.4.64.0610171853160.25484@lancer.cnet.absolutedigital.net>
	 <m1wt6y70kg.fsf@ebiederm.dsl.xmission.com>
	 <1161169330.9363.11.camel@localhost.localdomain>
	 <m1irig5oli.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 17:35:15 +0100
Message-Id: <1161275715.17335.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 09:09 -0600, ysgrifennodd Eric W. Biederman:
> > Not the core basic ones that are those people care about
> 
> I agree.  It just appears that the core basic ones that people
> care about is the empty set.

You should read linux-kernel or the other lists and look at the
complaints the deprecation caused, its not an empty set. It isn't a
large set apparently either however.

> >  **  the sysctl() binary interface.  However this interface
> >  **  is unstable and deprecated and will be removed in the future. 
> >  **  For a stable interface use /proc/sys.

This is a bit self-referential and self-inflicted. I wish to deprecate
it wrongly because there is a comment that it is deprecated wrongly.


