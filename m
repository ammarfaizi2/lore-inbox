Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbUCLU4t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUCLUyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:54:32 -0500
Received: from pop.gmx.net ([213.165.64.20]:39883 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262521AbUCLUxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:53:25 -0500
X-Authenticated: #1226656
Date: Fri, 12 Mar 2004 21:53:21 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 on Alpha uninterruptible sleep of processes
Message-Id: <20040312215321.1945a41e@hdg.gigerstyle.ch>
In-Reply-To: <20040312224649.A750@den.park.msu.ru>
References: <20040312154613.7567adab@hdg.gigerstyle.ch>
	<20040312182754.A680@jurassic.park.msu.ru>
	<20040312184115.B680@jurassic.park.msu.ru>
	<20040312165907.626d4a08@hdg.gigerstyle.ch>
	<20040312224649.A750@den.park.msu.ru>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004 22:46:49 +0300
Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:

> On Fri, Mar 12, 2004 at 04:59:07PM +0100, Marc Giger wrote:
> > Too late. Already applied, compiled and booted. Read your message
> > and rebooted to 2.4:-)
> 
> Well, you can try the appended patch to see whether it's
> a semaphore problem or not.
> BTW, what alpha system do you have?

Oh, it's an LX164 ev56 @ 533Mhz
