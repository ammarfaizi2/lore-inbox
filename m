Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265002AbUFXN6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbUFXN6o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 09:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUFXN6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 09:58:44 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:65291 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265002AbUFXNxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 09:53:45 -0400
Date: Thu, 24 Jun 2004 15:53:43 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Greg KH <greg@kroah.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Mariusz Mazur <mmazur@kernel.pl>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.7.0
Message-ID: <20040624135343.GH3072@pclin040.win.tue.nl>
References: <200406240102.23162.mmazur@kernel.pl> <40DA16E8.6070902@nortelnetworks.com> <20040624055832.GA10531@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624055832.GA10531@kroah.com>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 10:58:32PM -0700, Greg KH wrote:
> On Wed, Jun 23, 2004 at 07:48:56PM -0400, Chris Friesen wrote:
> > 
> > Maybe this should be a topic for the kernel summit or a BOF session at
> > OLS?
> 
> I don't see any objections, just no patches have been submitted that do
> this work.  Why would a BOF be needed to create a patch?  :)

Let me contradict this. Several people, probably independently,
submitted a header setup and a patch that did the required work
for a small handful of header files.

As far as I know Linus has not reacted to such patches.

Since the total amount of work is, like Jeff says, incredibly long and tedious,
it is unreasonable to expect that all be done before anything is put in the
default kernel tree.

At some point in time Linus either has to describe his setup, or
accept a setup someone submits.  Maybe a BOF would be useful to
find out precisely what requirements there are, but only if Linus
is present, because we have had enough discussion already.

Andries

