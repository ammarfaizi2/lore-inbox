Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbTHZPl3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTHZPl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:41:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:42645 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261509AbTHZPl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:41:28 -0400
Date: Tue, 26 Aug 2003 08:39:24 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Russell King <rmk@arm.linux.org.uk>
cc: kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       <torvalds@osdl.org>
Subject: Re: [PM] Config Options
In-Reply-To: <20030824125413.B16635@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0308260836340.942-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Pat, can we have a set of configuration options to disable a lot of the
> generic (!) code in kernel/power/*.c which isn't useful on embedded
> platforms?
> 
> I'm looking at stuff like the swsusp infrastructure for clearing out
> memory, suspending to disk, the PM state management, etc?  This type
> of stuff isn't at all useful on embedded platforms.

Sure, no problem.


	Pat

