Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTELWQx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbTELWQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:16:52 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:48429 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262931AbTELWQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:16:51 -0400
Subject: Re: PCMCIA 2.5.X sleeping from illegal context
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Hinds <dahinds@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1052773631.31825.18.camel@dhcp22.swansea.linux.org.uk>
References: <1052775331.1995.49.camel@diemos>
	 <1052773631.31825.18.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1052742964.1467.3.camel@doobie>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 May 2003 07:36:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-12 at 16:07, Alan Cox wrote:
> On Llu, 2003-05-12 at 22:35, Paul Fulghum wrote:
> > The 2.5.X PCMCIA kernel support seems to have a problem
> > with drivers/pcmcia/rsrc_mgr.c in function undo_irq().
> 
> Does this still happen with all the patches Russell King posted
> that everyone else is ignoring ?

I don't know, I've been ignoring them :-)

Seriously, are they centralized someplace or
should I scan back and try to extract them
from the lk archive? Do you know about when
they were posted?

Thanks,
Paul

Paul Fulghum
paulkf@microgate.com


