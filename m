Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbTESVHl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTESVHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:07:41 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:6630 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262912AbTESVHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:07:39 -0400
Date: Mon, 19 May 2003 14:16:54 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgmyers@netscape.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: aio_poll in 2.6
Message-Id: <20030519141654.31901ee3.akpm@digeo.com>
In-Reply-To: <1053373716.29227.27.camel@dhcp22.swansea.linux.org.uk>
References: <fa.mc7vl0v.u7u2ah@ifi.uio.no>
	<200305170054.RAA10802@pagarcia.nscp.aoltw.net>
	<20030516195025.4bf5dd8d.akpm@digeo.com>
	<200305191938.MAA11946@pagarcia.nscp.aoltw.net>
	<1053373716.29227.27.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 May 2003 21:20:32.0609 (UTC) FILETIME=[7AFA7D10:01C31E4C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Llu, 2003-05-19 at 20:38, John Myers wrote:
> > Andrew Morton wrote:
> > > What is the testing status of this?
> > 
> > I've beaten on it with my multithreaded test program on a 2-way
> > Pentium II box.
> 
> Can someone beat this code up on an SMP PPC/PPC64 box - that would show
> up far more than x86 does
> 

I can do that, but would need the test app...
