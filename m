Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267576AbUH0UWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbUH0UWz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUH0UWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:22:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:54485 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267576AbUH0UVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:21:18 -0400
Date: Fri, 27 Aug 2004 13:21:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kenneth Lavrsen <kenneth@lavrsen.dk>
cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       pmarques@grupopie.com, greg@kroah.com, nemosoft@smcc.demon.nl,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: pwc+pwcx is not illegal
In-Reply-To: <6.1.2.0.2.20040827215143.01d7b038@inet.uni2.dk>
Message-ID: <Pine.LNX.4.58.0408271313060.14196@ppc970.osdl.org>
References: <1093634283.431.6370.camel@cube> <Pine.LNX.4.58.0408271226400.14196@ppc970.osdl.org>
 <6.1.2.0.2.20040827215143.01d7b038@inet.uni2.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Aug 2004, Kenneth Lavrsen wrote:
> 
> Try and see this from the developers perspective and then remember that he 
> is a human beeing.

Hey, have you read the thread at all?

Respecting the developer is exactly why the code has been removed.

Being a developer gives you not only legal rights, but lots of other
rights. One right IT DOES NOT give you, though, is the right to add binary
hooks. That right is overridden by respecting other _developers_ rights.

Linux is all about open source. It's about making the best possible OS, 
and being as user-friendly as possible, but it's about doing so within the 
overriding goal of everybody being able to work together on the thing. 

So please respect _our_ work. 

I'm personally pretty optimistic that something can be worked out.  But it
will not happen by users whining - it will happen by users askign nemosoft
politely to avoid the kernel hooks, or by other users deciding to step up
to the plate and becoming developers.

			Linus
