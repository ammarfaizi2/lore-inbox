Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265297AbTFVN5b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 09:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265402AbTFVN5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 09:57:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53768 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265297AbTFVN53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 09:57:29 -0400
Date: Sat, 21 Jun 2003 08:42:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: davidm@hpl.hp.com
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: common name for the kernel DSO
Message-ID: <20030621064235.GA3044@zaurus.ucw.cz>
References: <16112.47509.643668.116939@napali.hpl.hp.com> <bcrkiq_dta_1@cesium.transmeta.com> <16113.22348.748334.416581@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16113.22348.748334.416581@napali.hpl.hp.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   HPA> It's a pretty ugly name, quite frankly, since it doesn't explain what
>   HPA> it is a gate from or to.  linux-syscall.so.1 or linux-kernel.so.1
>   HPA> would make a lot more sense.
> 
> Umh, it does say _linux_-gate, so I think it's pretty
> self-explanatory.  I considered linux-kernel.so, but think it would
> cause a lot of confusion vis-a-vis, say, kernel32.dll (I didn't write
> that, did I??).  I'm not terribly fond of linux-syscall, but I could
> live with it.

I agree with hpa, linux-syscall seems to be best so far.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

