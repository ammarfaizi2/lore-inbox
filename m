Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTHZWQX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 18:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTHZWQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 18:16:23 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:17536 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262942AbTHZWQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 18:16:20 -0400
Date: Tue, 26 Aug 2003 23:25:40 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308262225.h7QMPe0J000367@81-2-122-30.bradfords.org.uk>
To: aradorlinux@yahoo.es, bunk@fs.tum.de
Subject: Re: linux-2.4.22 released
Cc: jamagallon@able.es, linux-kernel@vger.kernel.org, retes_simbad@yahoo.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Reasons against:
> > <write here your opinion>
> >...
>
> - ALSA is big and there are still some bugs in ALSA; there are more
>   urgent things to be fixed in 2.4
> - it's easy to use ALSA even when it's not inside the kernel
> - within a few months 2.6.0 will be released with ALSA included -
>   together with the point above I don't see a reason why ALSA would be
>   badly needed in 2.4

I think the 'more urgent things to be fixed' point is important.

Only a certain amount of patches can go in to 2.4.23 if we want to
keep this a short development cycle, and efforts to stabilise 2.4 so
that embedded users who are still using 2.2 have something to migrate
to are important.

I'd like to see 2.4 become the stable choice for embedded users that
2.2 is now, before 2.6 becomes the standard for new non-embedded
machines within a year.

John.
