Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbTIOHfD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 03:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbTIOHfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 03:35:03 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:39552 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261186AbTIOHfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 03:35:00 -0400
Date: Mon, 15 Sep 2003 08:45:48 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309150745.h8F7jmbG000739@81-2-122-30.bradfords.org.uk>
To: bunk@fs.tum.de, neuffer@neuffer.info
Subject: Re: [1/4] [2.6 patch] better i386 CPU selection
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Is there a valid reason why you removed most of the
> > > descriptions ? I think a bit of a background on the
> > > CPU selections is helpful and interesting, especially 
> > > for newcommers. You've cut it down so far, that you 
> > > could also put there "Read Variable Name" or 
> > > "No help available"  instead.
> > 
> > With the CPU selection scheme I propose this is no longer true. 
> > Especially the f00f workaround is no longer disabled when configuring 
> > for a Pentium Pro or above, it's only enabled when you select the older 
> > Pentium - but this setting is now independend of the Pentium Pro 
> > setting.
>
> OK, bad example. What about the rest ?

I don't think we need verbose help texts anymore with the new
selection scheme, but background info describing various workarounds
would be a useful addition to /Documentation.

John.
