Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbTHTFrl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 01:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbTHTFrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 01:47:41 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:14720 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261720AbTHTFrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 01:47:40 -0400
Date: Wed, 20 Aug 2003 06:59:18 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308200559.h7K5xIK2000438@81-2-122-30.bradfords.org.uk>
To: jamie@shareable.org, john@grabjohn.com
Subject: Re: Input issues - key down with no key up
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl,
       neilb@cse.unsw.edu.au, vojtech@suse.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Also, the keyboard I'm using requires Set 3 to operate fully, although
> > as it's quite possible that I am the only person on the planet who
> > uses this model of keyboard with Linux, that might not be a very valid
> > argument :-).
>
> It's unfortunate if there are some keyboards that only work properly
> in one mode, and others that need the other mode, given that there is
> no way to automatically detect which keyboard is which.

It does work in Set 2, but the Japanese keys generate the same
scancode as the space bar.  Those keys are only generate unique
scancodes in Set 3.  Most Japanese keyboards do work fully in Set 2,
this one is an exception.

John.
