Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbTJNLAM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 07:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbTJNLAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 07:00:12 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:42881 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262333AbTJNLAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 07:00:09 -0400
Date: Tue, 14 Oct 2003 12:01:00 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310141101.h9EB10sB001460@81-2-122-30.bradfords.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20031014105514.GH765@holomorphy.com>
References: <20031014105514.GH765@holomorphy.com>
Subject: Re: mem=16MB laptop testing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (g) X isn't terribly swift; it's slower than I remember old Sun IPC's
> 	being, though they had 24MB RAM. OTOH luserspace is much more
> 	bloated these days. zsh alone is at least 3 times the size of
> 	ksh, which I used back then. fvwm2 is a lot bigger than fvwm1.
> 	And so on and so forth. I guess the upshot is "unbloating" the
> 	kernel wouldn't do much good anyway, since luserspace isn't in
> 	any kind of shape to run in this kind of environment anymore either.

Depends on what you consider usable.  I thought X worked pretty well
in swapless 8MB last time I tried it, (last year, around 2.5.40).
Admittedly that was only running a few xterms locally.  A 4MB + 20MB
swap box was suprisingly usable for fairly intense remote applications
over a compressed 9600 bps serial link.

John.
