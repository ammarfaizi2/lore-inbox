Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbVJFAFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbVJFAFz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 20:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbVJFAFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 20:05:55 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:37858 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1030453AbVJFAFy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 20:05:54 -0400
Date: Thu, 6 Oct 2005 02:07:41 +0200
To: Emmanuel Fleury <fleury@cs.aau.dk>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: freebox possible GPL violation
Message-ID: <20051006000741.GC18080@aitel.hist.no>
References: <20051005111329.GA31087@linux.ensimag.fr> <4343B779.8030200@cs.aau.dk> <1128511676.2920.19.camel@laptopd505.fenrus.org> <4343BB04.7090204@cs.aau.dk> <1128513584.2920.23.camel@laptopd505.fenrus.org> <4343C0DB.9080506@cs.aau.dk> <1128514062.2920.27.camel@laptopd505.fenrus.org> <4343C73E.9000507@cs.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4343C73E.9000507@cs.aau.dk>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 02:29:50PM +0200, Emmanuel Fleury wrote:
> Arjan van de Ven wrote:
[...]
> > they don't do a)
> > 
> > they don't do b)
> > 
> > c) is only for noncommerial distribution (not the case here) and only if
> > they got it in a type b) before, eg it allows you to transfer a type b)
> > in the non-commerical case.
> 
> First, it is very arguable to say that they are "distributing" the
> software as it does not comes with the FreeBox but is automatically
> downloaded at each boot through the DSLAM network (which the user is not
> supposed to know about).

If the box downloads a linux kernel through the DSLAM network, then
someone is clearly distributing linux kernels through the DSLAM network.
I would guess it is the same guys, because relying on someone else providing
them with kernels is a risky business.  But whoever is on the other end
of the DSLAM net have to offer the source as well, because they _are_
distributing kernels.

The fact that the user isn't supposed to know how this box work
doesn't change anything, of course.  The GPL says those who 
distribute the work - it doesn't matter that they don't tell the
customer that they're given a linux kernel. They still have to offer
the source if asked.


Helge Hafting
