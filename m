Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267564AbSKQTgL>; Sun, 17 Nov 2002 14:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267565AbSKQTgL>; Sun, 17 Nov 2002 14:36:11 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18770 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267564AbSKQTgK>; Sun, 17 Nov 2002 14:36:10 -0500
To: Larry McVoy <lm@bitmover.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
References: <1037490849.24843.11.camel@irongate.swansea.linux.org.uk>
	<Pine.LNX.4.44.0211161915360.1337-100000@home.transmeta.com>
	<20021116193008.C25741@work.bitmover.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Nov 2002 12:42:47 -0700
In-Reply-To: <20021116193008.C25741@work.bitmover.com>
Message-ID: <m11y5k3ruw.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As long as the network console/debug interface includes basic a basic
check to verify that the packets it accepts are from the local network.
And it's outgoing packets have a ttl of one.  I don't have a problem.

Otherwise the concept gives me security nightmares.

Eric
