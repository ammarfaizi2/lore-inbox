Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbTHTPSP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 11:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbTHTPSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 11:18:15 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:17538 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261989AbTHTPSO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 11:18:14 -0400
Date: Wed, 20 Aug 2003 16:17:28 +0100
From: Jamie Lokier <jamie@shareable.org>
To: John Bradford <john@grabjohn.com>
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl,
       neilb@cse.unsw.edu.au, vojtech@suse.cz
Subject: Re: Input issues - key down with no key up
Message-ID: <20030820151728.GA22204@mail.jlokier.co.uk>
References: <200308200559.h7K5xIK2000438@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308200559.h7K5xIK2000438@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> > > Also, the keyboard I'm using requires Set 3 to operate fully, although
> > > as it's quite possible that I am the only person on the planet who
> > > uses this model of keyboard with Linux, that might not be a very valid
> > > argument :-).
> >
> > It's unfortunate if there are some keyboards that only work properly
> > in one mode, and others that need the other mode, given that there is
> > no way to automatically detect which keyboard is which.
> 
> It does work in Set 2, but the Japanese keys generate the same
> scancode as the space bar.  Those keys are only generate unique
> scancodes in Set 3.  Most Japanese keyboards do work fully in Set 2,
> this one is an exception.

So do the Japanese keys fail to work in Windows, too, without a
special driver?

-Jamie
