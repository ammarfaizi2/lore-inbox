Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbTJ0Wgz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 17:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263675AbTJ0Wgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 17:36:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:49852 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263666AbTJ0Wgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 17:36:53 -0500
Date: Mon, 27 Oct 2003 14:46:26 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Jamey Hicks <jamey.hicks@hp.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: rename legacy bus to platform bus
In-Reply-To: <3F97EF84.2060901@hp.com>
Message-ID: <Pine.LNX.4.44.0310271445210.13116-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Many of us, especially in the embedded computing world, think that 
> "legacy bus" is a misnomer.  It's not going away.  What do root PCI 
> buses connect to?  At the root of the device tree there is a bus.  This 
> patch changes the name from legacy bus to platform bus.  I'm hoping this 
> change can be made even this late in the development cycle.  It is a 
> pretty small patch but I think that naming is very important.

Thanks, I've been meaning to fix it for some time. However, it didn't 
apply: 

patching file drivers/base/platform.c
Hunk #3 FAILED at 105.
Hunk #4 FAILED at 136.
Hunk #5 FAILED at 447.
Hunk #6 FAILED at 111.
Hunk #7 FAILED at 372.
5 out of 7 hunks FAILED -- saving rejects to file 
drivers/base/platform.c.rej

Care to fix it? 

Thanks,


	Pat

