Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSFTUUI>; Thu, 20 Jun 2002 16:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSFTUUH>; Thu, 20 Jun 2002 16:20:07 -0400
Received: from ajax.rutgers.edu ([128.6.10.9]:38590 "EHLO ajax.rutgers.edu")
	by vger.kernel.org with ESMTP id <S315442AbSFTUUF>;
	Thu, 20 Jun 2002 16:20:05 -0400
Date: Thu, 20 Jun 2002 16:19:59 -0400 (EDT)
From: zaimi@pegasus.rutgers.edu
To: linux-kernel@vger.kernel.org, Rob Landley <landley@trommello.org>
Subject: Re: kernel upgrade on the fly
Message-ID: <Pine.GSO.4.44.0206201600470.9816-100000@pegasus.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the responses especially Rob. I was trying to find previous
threads about this and could not find them. Agreed, swsusp is a step
further to that goal; the way that memory is saved though may not make it
necessarily easier, at least in the current state of swsusp.

As you were mentioning, the processes information needs
to be summarised and saved in such a way that the new kernel can pick up
and construct its own queues of processes independent on the differences
between the kernels being swapped.

Well, this does touch the idea of having migrating processes from one
machine to others in a network. In fact, I dont understand why is it so
hard to reparent a process. If it can be reparented within a machine, then
it can migrate to other machines as well, no?

Rob, I am going to the Newark campus FYI, and have interests in some AI
stuff.
Thanks again,

Adi

