Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbTISPhh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 11:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbTISPhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 11:37:37 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:62336 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261607AbTISPhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 11:37:35 -0400
Date: Fri, 19 Sep 2003 16:41:59 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309191541.h8JFfxBH000920@81-2-122-30.bradfords.org.uk>
To: jw@pegasys.ws, linux-kernel@vger.kernel.org
Subject: Re: bug database was: [PATCH] status update of loop
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > ... and Linux is still to[sic] immature to have a central bugtracking
> > database (one which is regularly checked by developers), > ...

Wrong.

I spent months developing a Kernel Bug Database, specifically for
Linux kernel development.

> The status of a central bug tracking database is not a
> measure of Linux's maturity.  It is a measure of the
> (perceived) maturity of acceptable bug tracking databases.

My Kernel Bug Database implemented things like searching for bugs
based on comparing entries in uploaded .config files, separation of
bug reports and confirmed bugs, archiving of old bug reports, and
categorisation of bug reports based on the MAINTAINERS file.

I'm sure there was desired functionality missing from it, but I never
got much response from my requests for a 'wish-list' of features.

> There are two ways to have developers use a bug-tracking
> system.  Have an authority with power over them compel
> them or make the database so useful to them that they have
> to be fools not to use it.

I don't honestly think we need a bug database.  The mailing list works
well enough.

I'm not actively working on my kernel bug database anymore.

John.
