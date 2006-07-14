Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161300AbWGNUyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161300AbWGNUyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 16:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161302AbWGNUyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 16:54:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9480 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1161300AbWGNUyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 16:54:45 -0400
Date: Fri, 14 Jul 2006 20:54:30 +0000
From: Pavel Machek <pavel@ucw.cz>
To: George Nychis <gnychis@cmu.edu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
Message-ID: <20060714205430.GD8731@ucw.cz>
References: <44B5CE77.9010103@cmu.edu> <44B604C8.90607@goop.org> <44B64F57.4060407@cmu.edu> <44B66740.2040706@goop.org> <44B6A9CA.8040808@cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B6A9CA.8040808@cmu.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Okay I think I am getting closer, after doing some searching it turns
> out that Hot pluggable CPU support is needed in the kernel to get
> suspend working on a thinkpad x60.
> 
> Now, what I thought was fixed from reading threads, may not be
> 
> I am running 2.6.18-rc1-git7 and whenever I suspend, and then restore,
> my screen remains black and I never get my shell back.  The machine
> seems to be alive because I can ping it, however I cannot ssh into it.
> 
> Any more ideas?

See suspend.sf.net, s2ram will fix the console for you.
-- 
Thanks for all the (sleeping) penguins.
