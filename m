Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWANLz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWANLz0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 06:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbWANLz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 06:55:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1153 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751030AbWANLz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 06:55:26 -0500
Date: Sat, 14 Jan 2006 03:54:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: "P. Christeas" <p_christ@hol.gr>
Cc: hch@lst.de, linux-kernel@vger.kernel.org, raven@themaw.net
Subject: Re: Regression in Autofs, 2.6.15-git
Message-Id: <20060114035456.3f50b0d8.akpm@osdl.org>
In-Reply-To: <200601141350.31033.p_christ@hol.gr>
References: <200601140217.56724.p_christ@hol.gr>
	<20060114033441.0d80b9f2.akpm@osdl.org>
	<200601141350.31033.p_christ@hol.gr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"P. Christeas" <p_christ@hol.gr> wrote:
>
> On Saturday 14 January 2006 1:34 pm, you wrote:
> > Thanks for working that out.
> >
> > It works for me.  Are you able to capture the oops output?
> Works in what sense? Are you able to reproduce the oops?

No, I am not.  I did `cd /net/<host>/usr/src' and things worked OK.

> It is quite difficult to reproduce the oops, since it makes the whole system 
> freeze (the fs part is oopsed, and then all processes depend on it). Hence 
> I've called it "hard" . It may be captured with a serial console, I 'll give 
> it a try..

OK, thanks.  Also if you're in the console a digital photo of the screen
works nicely.
