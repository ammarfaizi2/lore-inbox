Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933349AbWKSV3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933349AbWKSV3g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 16:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933351AbWKSV3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 16:29:36 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:62136 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S933349AbWKSV3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 16:29:35 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] PM: suspend/resume debugging should depend on  SOFTWARE_SUSPEND
Date: Sun, 19 Nov 2006 22:25:51 +0100
User-Agent: KMail/1.9.1
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <200611191955.23782.rjw@sisk.pl> <Pine.LNX.4.64.0611191153200.3692@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611191153200.3692@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611192225.52074.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 19 November 2006 20:54, Linus Torvalds wrote:
> 
> On Sun, 19 Nov 2006, Rafael J. Wysocki wrote:
> > 
> > > because people point to the suspend-to-disk instead.
> > 
> > Who they?
> 
> Like you _just_ did.

No, I didn't.  It was referred to in the message that started this thread.

I don't remeber telling _anyone_ not to use the STR and use the STD instead.

> > >  - enable PM_DEBUG, and PM_TRACE
> > 
> > This only works on i386, no?
> 
> Right now the trivial functions are only available on i386, yes. The 
> concept works anywhere that has a CMOS chip, so if somebody were to spend 
> a few minutes testing it on x86-64 and others, it would work elsewhere 
> too..

I can do that if someone gives me the code.

> > I don't know of anyone who's doing that.
> 
> I know. I'm probably the only one. Frustrating.

Well, it isn't that well documented ...

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
