Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTLSPjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 10:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbTLSPjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 10:39:22 -0500
Received: from vena.lwn.net ([206.168.112.25]:42464 "HELO lwn.net")
	by vger.kernel.org with SMTP id S263388AbTLSPjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 10:39:21 -0500
Message-ID: <20031219153920.28201.qmail@lwn.net>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Device Drivers 3rd Edition 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Thu, 18 Dec 2003 23:51:34 PST."
             <Pine.LNX.4.10.10312182350160.7879-100000@master.linux-ide.org> 
Date: Fri, 19 Dec 2003 08:39:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So this is the third release to publish the documented API to the writing
> kernel level device drivers?

I guess I see it as more of a map of the jungle as I (and my co-authors)
see it.  A guide to New York does not automatically open all of the doors
of the city to you; should a guide to certain parts of the kernel be
different?  

There was an informative article in Phrack a while back on how to install
code into a running kernel via /dev/kmem.  I guess that must be a
documented API too, now.

jon
