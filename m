Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263180AbVCDXc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263180AbVCDXc0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbVCDXXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:23:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:10906 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263229AbVCDVQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:16:00 -0500
Date: Fri, 4 Mar 2005 13:15:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, chrisw@osdl.org, torvalds@osdl.org
Subject: Re: Linux 2.6.11.1
Message-Id: <20050304131537.7039ca10.akpm@osdl.org>
In-Reply-To: <20050304205842.GA32232@kroah.com>
References: <20050304175302.GA29289@kroah.com>
	<20050304124431.676fd7cf.akpm@osdl.org>
	<20050304205842.GA32232@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> > Here's the list of things which we might choose to put into 2.6.11.2.  I was
>  > planning on sending them in for 2.6.12 when that was going to be
>  > errata-only.
> 
>  Ok, care to forward them on?

Sure.  How do they get to Linus?

>  Hm, odds are the nfsd one doesn't fit our list of "acceptable things",

Was there such a list?  It's kinda what I'm asking about here.

Yes, the NFSD fixes are relatively minor, although Neil did want them in
the 2.6.12 errata kernel.

Perhaps they could be backported to 2.6.11.x in a few weeks ;)
