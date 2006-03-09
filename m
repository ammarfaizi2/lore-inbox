Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWCIXaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWCIXaX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbWCIXaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:30:22 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:54515 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750777AbWCIXaV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:30:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PpoyObXBQf60SC7Rbeez7qHjN0cAL2vzSmZ+8pkZ9SZ5BK41F2dpApXcC2vslmsg1KemGi/AvUb6vbPYZIdQOt459R1v71xdBgtRzG3quEQEl1+dpbnhDNjqZimq6VAD6sjUse/GSHyEudVoIKqLqprn8IrQh/5pj34qP/QnSPs=
Message-ID: <161717d50603091530v1ce55197l7448228c1219462@mail.gmail.com>
Date: Thu, 9 Mar 2006 18:30:20 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: davids@webmaster.com
Subject: Re: [future of drivers?] a proposal for binary drivers.
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEPJKJAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <161717d50603090713r50471974tb0089863324e88c0@mail.gmail.com>
	 <MDEHLPKNGKAHNMBLJOLKEEPJKJAB.davids@webmaster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/06, David Schwartz <davids@webmaster.com> wrote:
>
> > Copyright law also absolutely
> > gives me monopoly power over derivitive works - you can't even create
> > a work derived from my dropped-from-airplane poem without my
> > permission, much less distribute one.
>
>        No, that's not true on two counts.
>
>        First, your last part "much less distribute one" is utterly false.
> Copyright law does not give you any special rights to restrict the
> distribution of derivative works.

You're being rather hyper-technical and semantic here, aren't you? You
clearly can't distribute something you can't legally "prepare" in the
first place.

>
>        Second, your first part, that it gives you monopoly power over the creation
> of derivative works is also false. First sale and fair use can give people
> the right to create derivative works.

OK, 14 USC 106(2) gives me monopoly power, subject to certain
restrictions. You seemed to have missed my point, as none of the
restrictions you mentioned include creation of derivative software
programs for commercial distribution.

In another reply, you wrote:
>
>        You cannot copyright an idea. "A Foo2000 SCSI driver for Linux 2.6" is an
> *idea*. So you cannot argue that you have copyright on every practically
> possible way to create such a driver.

Your argument, if extended to fiction, is equivalent to "'An
elaboration of Gone With the Wind' is an idea." There may be such a
thing as an idea corresponding to "an elaboration of Gone With the
Wind," but once a reader has the embodiment of that idea in their
hands, a work subject to copyright has obviously been created, and
it's up to the courts to decide whether it's a derived work or not.

Linux is a copyrighted work, so "A Foo2000 SCSI driver for Linux 2.6,"
once it gets embodied in software, unless it's implemented in
userspace, is most likely going to be a work derived from the
copyrighted expression which is the linux kernel.

I don't think a software company is going to get away with declaring
that their driver is parody (though I've seen code that appears to be
a parody of computer programming generally), and if they're careful
enough not to use the same symbols as me... well, they won't have
created a derived work, but  other important senses of the word "work"
probably won't apply to their program, either.

Anyway, since I'm not a lawyer and no one is suing anyone, I'm really,
really done now.

Night,
Dave
