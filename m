Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbTJMAWM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 20:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbTJMAWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 20:22:12 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:55763 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id S261267AbTJMAWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 20:22:09 -0400
Date: Mon, 13 Oct 2003 02:22:03 +0200
From: Domen Puncer <domen@coderock.org>
Subject: Re: 3c59x on 2.6.0-test3->test6 slow
In-reply-to: <200310100155.53205.domen@coderock.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <200310130222.03175.domen@coderock.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.4
References: <200310061529.56959.domen@coderock.org>
 <Pine.LNX.4.53.0310091904400.3679@montezuma.fsmlabs.com>
 <200310100155.53205.domen@coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 of October 2003 01:55, Domen Puncer wrote:
> On Friday 10 of October 2003 01:10, Zwane Mwaikambo wrote:
> > On Thu, 9 Oct 2003, Domen Puncer wrote:
> > > > > eth0: negotiated 100baseTx-FD, link ok
> > > > > when it is ok (reloaded -test2 module)
> > > >
> > > > What does mii-tool -r do?
> > >
> > > Doesn't help, neither do -R or -F.
> >
> > Ok to recap, backing out the WOL change fixes things? If not, can you
> > isolate which kernel version it is?
>
> -after the WOL change... works slow, no matter what i do.
> -before the WOL change... works slow, but rmmod/modprobe fixes this.
>
> Will try with drivers from older kernels, when i wake up.

Ok... i woke up :-)

Tried a bunch of 2.5.x kernels... no better.
Then i tried 2.4.22... and my nic still doesn't work fast.

What can i do?


	Domen

