Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271073AbTHLUKH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 16:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271082AbTHLUKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 16:10:07 -0400
Received: from monk.debian.net ([216.226.142.128]:25036 "EHLO monk.verbum.org")
	by vger.kernel.org with ESMTP id S271073AbTHLUKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 16:10:04 -0400
Subject: Re: [Rhythmbox-devel] Re: Linux 2.6 doesn't like Rhythmbox
From: Colin Walters <walters@verbum.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: in7y118@public.uni-hamburg.de, LKML <linux-kernel@vger.kernel.org>,
       rhythmbox-devel@gnome.org, gstreamer-devel@lists.sourceforge.net
In-Reply-To: <1060704354.856.1.camel@teapot.felipe-alfaro.com>
References: <1060699703.3f38fe37b8a1f@rzaixsrv6.rrz.uni-hamburg.de>
	 <1060704354.856.1.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060718834.13694.1.camel@columbia>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 12 Aug 2003 16:07:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-12 at 12:05, Felipe Alfaro Solana wrote:

> Don't blame anyone still... There's still ongoing kernel scheduler work.
> Please, try the latest -mm patches on top of 2.6.0-test3. You will find
> them at ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches.
> 
> Experiment with 2.6.0-test3-mm1 to see if it still shows the behaviour
> you described.

Yeah, I had a great experience with 2.6.0-test2-mm for interactivity;
Rhythmbox almost never skipped.  However I had to go back to 2.4.21
because APM stopped working in 2.6.0-test2-mm, and ACPI never worked
(both freeze on startup).  -test3 didn't help either...


