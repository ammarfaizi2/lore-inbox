Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbTGNLPB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 07:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbTGNLPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 07:15:01 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:48256 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266169AbTGNLO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 07:14:58 -0400
Date: Mon, 14 Jul 2003 12:39:00 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307141139.h6EBd09g000700@81-2-122-30.bradfords.org.uk>
To: alan@lxorguk.ukuu.org.uk, john@grabjohn.com
Subject: Re: Linux v2.6.0-test1
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The point of the test versions is to make more people realize that they
> > > need testing
> > 
> > Are all the known security issues in 2.4 now fixed in 2.6.0-test1?
>
> No, and several more have been added in 2.6-test only.

As far as I know, they are only information disclosure ones, not
directly exploitable vulnerabilities, or am I wrong?

> > This has been the only major reason for keeping of most of my
> > production machines running 2.4 for quite a while.  If not, can we get
> > the fixes in at the earliest opportunity?
>
> Sure.. send the fixes to Linus

Is anybody even keeping track of this, though?  Picking thorough LKML
to see what did and didn't go in doesn't seem particularly exciting to
me.

John.
