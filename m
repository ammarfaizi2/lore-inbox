Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbTJGQO2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 12:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbTJGQO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 12:14:28 -0400
Received: from gprs149-208.eurotel.cz ([160.218.149.208]:55937 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262441AbTJGQO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 12:14:27 -0400
Date: Tue, 7 Oct 2003 18:12:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, paul.devriendt@amd.com,
       kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: powernow-k8: don't crash system at boot
Message-ID: <20031007161216.GA610@elf.ucw.cz>
References: <20031005190056.GA863@elf.ucw.cz> <20031007160346.GD29736@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031007160346.GD29736@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> <Please don't send these to Rusty, such changes are far from trivial.
>  Not that I don't trust Rusty to pass on them, but it's one less thing
>  he has to worry about..>

Okay, next time only static's and like go to the rusty.

>  > powernow-k8 module fails to initialize government on boot, leading to
>  > nasty crash at boot.
> 
> See below.
> 
>  > This fixes it. Plus find_closest_find really wants to be static. Fix
>  > it, too.
> 
> Applied. Thanks.


Thanks.
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
