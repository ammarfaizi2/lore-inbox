Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbTJaUJy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 15:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTJaUJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 15:09:54 -0500
Received: from rth.ninka.net ([216.101.162.244]:32926 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263564AbTJaUJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 15:09:52 -0500
Date: Fri, 31 Oct 2003 12:06:31 -0800
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, david-b@pacbell.net, greg@kroah.com,
       vojtech@suse.cz, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
Message-Id: <20031031120631.6d209a3f.davem@redhat.com>
In-Reply-To: <16290.48361.970446.61879@napali.hpl.hp.com>
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>
	<20031028013013.GA3991@kroah.com>
	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>
	<3FA12A2E.4090308@pacbell.net>
	<16289.29015.81760.774530@napali.hpl.hp.com>
	<16289.55171.278494.17172@napali.hpl.hp.com>
	<3FA28C9A.5010608@pacbell.net>
	<16290.43822.444275.360988@napali.hpl.hp.com>
	<3FA2B7D4.5010707@pacbell.net>
	<16290.48361.970446.61879@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Oct 2003 11:50:01 -0800
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> >>>>> On Fri, 31 Oct 2003 11:28:20 -0800, David Brownell <david-b@pacbell.net> said:
> 
>   David.B> You sound alarmed!  If that's alarmed enough to find out
>   David.B> what the real problem is, maybe you'll end up fixing it
>   David.B> ... :)
> 
> Except I know almost nothing about the USB stack.

David, get real, this is never an excuse for people of our
caliber.  :-)

You, myself, and many others are more than intelligent enough and more
than capable enough to debug subsystems we are not familiar with or
even have never looked at before.

As platforms maintainers, such a skill is nearly a necessity.

When I hit a problem in some subsystem and I can't provide enough
information to the subsystem maintainer for them to fix the bug, I
have to do the debugging work if I want the bug fixed.
