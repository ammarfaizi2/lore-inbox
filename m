Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269527AbUJWBCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269527AbUJWBCW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269759AbUJWA6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:58:41 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:4415 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269752AbUJWA5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:57:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=q8byJmwSl4tHprOOvFQc7kZTFC5p2UXisuS3AHK5Kp0lFKus75jqQ2mFDR6K/VPHpGrUwclcItMjW/RhZrLypGDSNu7lIeimAc4SXrZCW0Ai2YIjjxCXzcuKIt5fMTOH40aifCpbg2k58vJkCSpBHoj8y56wQNY4KYEKo+kcAY4=
Message-ID: <35fb2e59041022175758ece5f9@mail.gmail.com>
Date: Sat, 23 Oct 2004 01:57:04 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Subject: Re: Linux v2.6.9 and GPL Buyout
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41799BEE.1030104@drdos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
	 <417550FB.8020404@drdos.com>
	 <35fb2e590410221714205fe526@mail.gmail.com>
	 <41799BEE.1030104@drdos.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004 17:46:54 -0600, Jeff V. Merkey <jmerkey@drdos.com> wrote:

> Jon Masters wrote:

> > Do you model your testing process on SCO
> > directly? i.e. can I have you go on record that your testing process
> > is satisfied after two days of testing?

> No. It's still running with the following metrics, it's been up all
> week, and it doesn't crash in 20 minutes, which it always did
> before, and my BIO multiple page requests don't corrupt
> memory anymore:

Ok great, that sounds good.

What happens when you try resetting those metrics with dd if=/dev/zero
of=/dev/mem?

> >>SCO has contacted us and identifed with precise detail and factual
> >>documentation the code and intellectual property in Linux they claim was
> >>taken from Unix. We have reviewed their claims and they appear to create enough
> >>uncertianty to warrant removal of the infringing portions.

> >Will you offer that as an undertaking, properly signed and sealed,
> >though? If these unfortunate sections of code are removed, will you
> >guarantee SCO won't sue?

> I have convinced Darl to post a program that will state exactly this.

I need you to commit to this in writing, signed and sealed though. Any
chance of doing this as per previous allusion?

> As far as RCU goes, there's so many three letter acronyms, RCU could
> stand for anything.

Yes it could indeed. However in the context of the Linux kernel it
tends to usually refer to the Read Copy Update technique as an
alternative to explicit locks.

Jon.
