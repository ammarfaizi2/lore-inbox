Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265438AbUAWJoI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 04:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266557AbUAWJoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 04:44:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:14565 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265438AbUAWJoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 04:44:04 -0500
Date: Fri, 23 Jan 2004 01:44:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: glennpj@charter.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm1 oops with X
Message-Id: <20040123014453.775a0ba7.akpm@osdl.org>
In-Reply-To: <1074850572.23073.83.camel@imladris.demon.co.uk>
References: <20040123061927.GA7025@gforce.johnson.home>
	<20040122231814.149c8e8d.akpm@osdl.org>
	<1074848612.23073.81.camel@imladris.demon.co.uk>
	<20040123011158.665ad574.akpm@osdl.org>
	<1074850572.23073.83.camel@imladris.demon.co.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Fri, 2004-01-23 at 01:11 -0800, Andrew Morton wrote:
> > > This is what GDB watchpoints were invented for, surely? 
> > 
> > I suppose that might help.  But for me the bug triggered towards the end of
> > initscripts (it moves around) after we've been through that code path a
> > zillion times.  It probably needs to be solved by inspection.  If one can
> > get it to happen reliably.
> 
> Can't you script it just to automatically show a backtrace and continue,
> then peruse the logs later?

I can't make it happen any more!  I suspect Heisenberg would get in the way
anyway.

