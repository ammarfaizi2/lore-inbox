Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbVCOK5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVCOK5o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 05:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbVCOK5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 05:57:44 -0500
Received: from B.painless.aaisp.net.uk ([81.187.81.52]:60544 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S262379AbVCOK5m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 05:57:42 -0500
Subject: Re: Problem with 2.6.11-bk[3456]
From: Andrew Clayton <andrew@digital-domain.net>
To: Dave Airlie <airlied@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <21d7e99705031502507704f50f@mail.gmail.com>
References: <1110492499.2666.8.camel@alpha.digital-domain.net>
	 <21d7e99705031502507704f50f@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 10:57:40 +0000
Message-Id: <1110884260.2732.8.camel@alpha.digital-domain.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 10:50 +0000, Dave Airlie wrote:
> > Got a problem here with the last few Linus -bk releases.
> > 
> > 2.6.11-bk2 is running fine.
> > 
> > 2.6.11-bk3 - 2.6.11-bk6 has the following problem:
> > 
> > Everything is fine while the machine is booting. However as soon as X
> > starts up the screen goes blank as normal but stays blank, no gdm login
> > screen and the hard disk and floppy drive lights are on continuously.
> > The machine is now locked up solid and needs a hard reset.
> > 

2.6.11-bk10 is a slight improvement in that the machine isn't completely
dead and I can ctrl+alt+delete it...

> This is the same problem as i just mailed everyone about.. more
> information here...
> 
> Dave.
> 

Cheers,

Andrew


