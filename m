Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbTIPJhD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 05:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbTIPJhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 05:37:03 -0400
Received: from gprs149-34.eurotel.cz ([160.218.149.34]:9088 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261555AbTIPJhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 05:37:01 -0400
Date: Tue, 16 Sep 2003 11:36:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nicolae Mihalache <mache@abcpages.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6-test4 problems: suspend and touchpad
Message-ID: <20030916093649.GA397@elf.ucw.cz>
References: <Pine.LNX.4.33.0309150949270.950-100000@localhost.localdomain> <3F662322.9060205@abcpages.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F662322.9060205@abcpages.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >It does not. Could you please try removing the module before you suspend? 
> >
> Yes, removing and readding the module does the trick.
> Unfortunately I've seen that something else does not work after resume: 
> my USB mouse.
> But for some reason I can not remove the usbcore module, the kernel says 
> it's in use.
> 
> Now, how can I help to solve these problems? Is somebody working to 
> solve these problems or should I try to solve them myself (at least with 
> the Broadcom 4400 driver) ?

Network driver should be reasonably easy to do; so please help :-).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
