Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWGYTbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWGYTbz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWGYTbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:31:55 -0400
Received: from 1wt.eu ([62.212.114.60]:63756 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S964844AbWGYTby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:31:54 -0400
Date: Tue, 25 Jul 2006 21:31:40 +0200
From: Willy Tarreau <w@1wt.eu>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       mtosatti@redhat.com
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Message-ID: <20060725193140.GK2037@1wt.eu>
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com> <200607181004.55191.benjamin.cherian.kernel@gmail.com> <20060718183313.e8e5a5b2.zaitcev@redhat.com> <200607201044.00739.benjamin.cherian.kernel@gmail.com> <20060724230732.4fdf2bf4.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060724230732.4fdf2bf4.zaitcev@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pete,

On Mon, Jul 24, 2006 at 11:07:32PM -0700, Pete Zaitcev wrote:
> On Thu, 20 Jul 2006 10:43:59 -0700, Benjamin Cherian <benjamin.cherian.kernel@gmail.com> wrote:
> 
> > > Although I am starting to think about creating a custom locking
> > > scheme in devio.c after all. It seems like less work.
> 
> > What's your timeframe for this? Good luck with it.
> 
> OK, now I hate my life, I hate you, I hate Stuart, but most of all
> I hate the anonymous Japanese who wrote the microcode for TEAC CD-210PU.
> Anyway, please test the attached patch. Does it do what you want?

I'm very glad that you're still maintaining 2.4 code so much actively. Do
you think of any possible side effects that non-TEAC users might encounter ?
If you feel more comfortable after some particular corner-case tests on other
hardware, please ask.

> -- Pete

Cheers,
Willy

