Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbTICS4q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTICSzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:55:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:48875 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264297AbTICSvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:51:40 -0400
Date: Wed, 3 Sep 2003 11:49:12 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: James Clark <jimwclark@ntlworld.com>
cc: <linux-kernel@vger.kernel.org>, <rml@tech9.net>, <root@chaos.analogic.com>,
       <alan@lxorguk.ukuu.org.uk>
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
In-Reply-To: <200309031850.14925.jimwclark@ntlworld.com>
Message-ID: <Pine.LNX.4.33.0309031141550.944-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Following my initial post yesterday please find attached my proposal for a 
> binary 'plugin' interface:

Whoa, whoa, whoa! Hang on there, cowboy. 

It's always easier to observe the behavior of a system from the outside
and make suggestions from that objective point of view (especially when
you have experience in another similar system). However, change can
ultimately only come from within.

We've always been open to outside suggestions, but they're really only 
useful when they contain implementation details (usualy in the form of 
working code) that build on top of our existing system. 

Linux is an evolutionary process. While it's tempting to project the 
behavior or ideals of another similar system on to it -- simply because 
you can -- it really doesn't work. We evolve and mutate and change. And, 
that's where we feel we are really superior. 

I've not read your proposal -- nor do I intend to -- even as maintainer of
the new driver model. I do however encourage you to pick up a copy of 
"Linux Device Drivers", read it, and start contributing to the development 
process. After getting a feel for how we work, reconsider your proposal, 
and submit some patches to implement your ideas. 

Until then, I'm not interested in discussing license issues or binary
modules, so please remove me from the CC list.

Thanks,


	Pat

