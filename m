Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbTJGX10 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 19:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbTJGX10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 19:27:26 -0400
Received: from mail.kroah.org ([65.200.24.183]:25831 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262855AbTJGX1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 19:27:19 -0400
Date: Tue, 7 Oct 2003 16:27:06 -0700
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs and udev
Message-ID: <20031007232706.GA3621@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <20031007131719.27061.qmail@web40910.mail.yahoo.com> <200310072128.09666.insecure@mail.od.ua> <20031007194124.GA2670@kroah.com> <200310072347.41749.insecure@mail.od.ua> <20031007205244.GA2978@kroah.com> <yw1xvfr0wxfa.fsf@users.sourceforge.net> <20031007213758.GB3095@kroah.com> <yw1xr81owvv0.fsf@users.sourceforge.net> <1065564766.1238.144.camel@serpentine.internal.keyresearch.com> <yw1x7k3gwtmi.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1x7k3gwtmi.fsf@users.sourceforge.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 08, 2003 at 12:49:41AM +0200, Måns Rullgård wrote:
> Bryan O'Sullivan <bos@serpentine.com> writes:
> 
> >> Can you point me to any documentation at all?
> >
> > Really, I don't know why Greg is bothering to answer your questions.
> >
> > This stuff is all readily accessible via (a) getting off your nethers
> > and doing a Google search for "linux udev" and (b) reading what you
> > find.  It's trivial to find, and it's utterly obvious how it works.
> 
> I followed the link provided in the Kconfig, and downloaded the files
> that seemed reasonable.  The only documentation I found there warned
> me against using it.

Then don't use it, no one is forcing you to.

But if you do, wow, look at the second Google link for "linux udev":
	http://www.ussg.iu.edu/hypermail/linux/kernel/0307.3/0495.html

Hey look, documentation, a presentation, and wow, a statement saying
that the code sucks, and is merely a proof of concept, and that it will
get better over time.  That's a zillion lines more of text than most
open source projects ever generate.

{sigh}

greg k-h
