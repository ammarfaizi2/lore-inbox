Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265437AbTFMRWs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 13:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265452AbTFMRWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 13:22:47 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:8320 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265437AbTFMRWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 13:22:42 -0400
Date: Fri, 13 Jun 2003 18:43:23 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306131743.h5DHhNdv000312@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, jsimmons@infradead.org, terje_fb@yahoo.no
Subject: Re: Real multi-user linux
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >     The next stage will be non PC boards supporting more than
> > one graphics display output. Every now and then you see such a
> > board. I seen a 8 graphics chip board with 8 video outputs.

> As the number of terminals increases you might want to investigate the
> possibility of terminal driving units connected to the main box, like
> this:

[snip diagram]

Of course, those terminal driving units could actually then just be
replaced with multiple-display-and-keyboard-enabled X servers.

So, instead of trying to add more and more terminals to a single box,
you could stick with four-headed X servers, which would probably be
more scalable.

John.
