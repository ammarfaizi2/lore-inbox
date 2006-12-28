Return-Path: <linux-kernel-owner+w=401wt.eu-S1755236AbXAAQ3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236AbXAAQ3l (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 11:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755227AbXAAQ3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 11:29:41 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4664 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755236AbXAAQ3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 11:29:33 -0500
Date: Thu, 28 Dec 2006 13:32:12 +0000
From: Pavel Machek <pavel@suse.cz>
To: Scott Preece <sepreece@gmail.com>
Cc: Wolfgang Draxinger <wdraxinger@darkstargames.de>,
       LKML <linux-kernel@vger.kernel.org>, Rok Markovic <kernel@kanardia.eu>
Subject: Re: Binary Drivers
Message-ID: <20061228133211.GD3955@ucw.cz>
References: <34142027@web.de> <458C308D.6070606@kanardia.eu> <200612222300.17463.wdraxinger@darkstargames.de> <7b69d1470612221414h7bca6dd3x89f52be55a47746d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b69d1470612221414h7bca6dd3x89f52be55a47746d@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >You're not alone, I think everybody who knows, how 
> >things in a
> >computer work shares this view.
> ---
> 
> Two of the specific arguments I've heard are (a) that 
> the board (and
> its hardware interfaces that the documentation would 
> describe) involve
> IP licensed from a third party, which the board 
> manufacturer does not
> have a legal right to disclose, or (b) that there is, in 
> fact, no
> suitable documentation, because the boards are developed 
> somewhat
> fluidly and the driver is developed directly from 
> low-level knowledge
> that simply isn't written down in a form suitable for 
> passing on.

So just opensource the driver. It is usually easy to port it, and
possible to clean it up.

I have once ported cd-rom driver from DOS to linux (do you still
remember cdroms not talking ATA?) -- in 2days or so, and the comments
in driver were in korean.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
