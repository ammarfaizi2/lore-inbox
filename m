Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTIPP6h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbTIPP6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:58:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:55736 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261950AbTIPP6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:58:34 -0400
Date: Tue, 16 Sep 2003 08:55:32 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Nicolae Mihalache <mache@abcpages.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6-test4 problems: suspend and touchpad
In-Reply-To: <3F662322.9060205@abcpages.com>
Message-ID: <Pine.LNX.4.33.0309160853290.958-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, removing and readding the module does the trick.
> Unfortunately I've seen that something else does not work after resume: 
> my USB mouse.

> Now, how can I help to solve these problems? Is somebody working to 
> solve these problems or should I try to solve them myself (at least with 
> the Broadcom 4400 driver) ?

AFAIK, there is no one working on either of these issues. I would
recommende contacting the maintainers about what it would take to
implement suspend/resume. They should hopefully have an idea of how to go 
about it, if not able to do it themselves.

Thanks,


	Pat

