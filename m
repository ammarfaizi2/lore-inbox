Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265519AbTFMUJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 16:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265520AbTFMUJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 16:09:55 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4224 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265519AbTFMUJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 16:09:53 -0400
Date: Fri, 13 Jun 2003 21:30:34 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306132030.h5DKUYlu000211@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, jsimmons@infradead.org
Subject: Re: Real multi-user linux
Cc: linux-kernel@vger.kernel.org, terje_fb@yahoo.no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So, instead of trying to add more and more terminals to a single box,
> > you could stick with four-headed X servers, which would probably be
> > more scalable.

> The biggest limitation is the PCI bus. Only so many cards can go in. I
> guess you could fill the machine up with graphics cards and go with
> external USB audio and TV tuner cards. One to match each graphics card.

No need:

A single machine can support four displays, keyboards, and mice easily.  We
can use such machines as X servers for four people.  Each one can be connected
via Ethernet to the Linux supercomputer.  That way you get the cost advantages
of the multi-headed setup, with the scalability of the X server setup.  I think
you could scale to 64 or 128 users like that.

John.
