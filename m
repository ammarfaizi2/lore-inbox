Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTKYRVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbTKYRVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:21:45 -0500
Received: from iisc.ernet.in ([144.16.64.3]:42132 "EHLO iisc.ernet.in")
	by vger.kernel.org with ESMTP id S262788AbTKYRVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:21:42 -0500
From: anand@eis.iisc.ernet.in (SVR Anand)
Message-Id: <200311251721.WAA25695@eis.iisc.ernet.in>
Subject: Re: 2.6.0-test9-bk25 : bridge works fine
To: davem@redhat.com (David S. Miller)
Date: Tue, 25 Nov 2003 22:51:21 +0530 (GMT+05:30)
Cc: torvalds@osdl.org (Linus Torvalds), linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <20031123152601.67646dc1.davem@redhat.com> from "David S. Miller" at Nov 23, 2003 03:26:01 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With test9-bk25, I am not facing any problem for the past many hours which
was not to be the case with test9. I am hopeful that it will work for ever.

Thanks a lot for all the help. Next time I should make it a point to try on 
the latest of the latest before shooting off a mail :)

Anand
> 
> On Sat, 22 Nov 2003 08:20:40 -0800 (PST)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > On Sat, 22 Nov 2003, SVR Anand wrote:
> > > 
> > > The problem is : After 3 to 4 hours of functioning, the bridge stops working 
> > > and the machine becomes unusable where it doesn't respond to keyboard, and 
> > > there is no video display.
> > 
> > Sounds like a memory leak somewhere. It would probably be interesting to 
> > watch /proc/slabinfo every five minutes or so, and see what happens..
> 
> Also, we've certainly fixed some serious networking bugs since test9
> came out.
> 

