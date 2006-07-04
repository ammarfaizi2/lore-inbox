Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWGDItT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWGDItT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWGDItT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:49:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16346 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932146AbWGDItT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:49:19 -0400
Date: Tue, 4 Jul 2006 01:49:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.17-mm6
Message-Id: <20060704014908.9782c85f.akpm@osdl.org>
In-Reply-To: <200607040934.14592.s0348365@sms.ed.ac.uk>
References: <20060703030355.420c7155.akpm@osdl.org>
	<200607032250.02054.s0348365@sms.ed.ac.uk>
	<20060703163121.4ea22076.akpm@osdl.org>
	<200607040934.14592.s0348365@sms.ed.ac.uk>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2006 09:34:14 +0100
Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> > a tested version...
> 
> This one worked, thanks. Try the same URL again, I've uploaded two better 
> shots 6,7 that capture the first oops. Unfortunately, I have a pair of oopses 
> that interchange every couple of boots, so I've included both ;-)

OK, that's more like it.  Thanks again.

http://devzero.co.uk/~alistair/oops-20060703/oops6.jpg
http://devzero.co.uk/~alistair/oops-20060703/oops7.jpg

People cc'ed.  Help!

Can you send the .config please?

> I suggest Andi picks up that debugging patch, it worked for me.

He'll be hearing from me ;)
