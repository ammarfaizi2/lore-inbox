Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUEKAXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUEKAXr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 20:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUEKAXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 20:23:47 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:24338 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262329AbUEKAXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 20:23:42 -0400
Date: Tue, 11 May 2004 01:23:40 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Jon Smirl <jonsmirl@yahoo.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <keithp@keithp.com>
Subject: Re: Is it possible to implement interrupt time printk's reliably?
In-Reply-To: <20040510222211.78262.qmail@web14922.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0405110101450.8016-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So how long is the delay between PCI probe time (when the framebuffer goes
> active) and when early user space is up with initrd? Or is initrd up first? If
> initrd is up first then early user space mode setting will occur at the same
> time that it does currently.

Why do we even need a fbdev layer then!!! We might as well remove it 
completly!!!!

Its totally destroy's my dream of a real multidesktop OS :-( This is why 
I'm so upset. Using userland libraries to do multidesktop OS is a really 
limited retarded way of doing it. I worked on this for 3 years. Testing 
different systems with different configurations. Now I realize it will die 
a painful death.





