Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbTIYHS2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 03:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbTIYHS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 03:18:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49575 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261739AbTIYHSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 03:18:25 -0400
Date: Tue, 23 Sep 2003 14:07:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How does one get paid to work on the kernel?
Message-ID: <20030923120715.GA11901@openzaurus.ucw.cz>
References: <1063915370.2410.12.camel@laptop-linux> <yw1xad91nrmd.fsf@users.sourceforge.net> <1063958370.5520.6.camel@laptop-linux> <m2he38r7ji.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2he38r7ji.fsf@tnuctip.rychter.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  Nigel> There is support in the current kernel for Software Suspend, but
>  Nigel> the 2.4 version contains a lot of extra functionality that isn't
>  Nigel> present in 2.6 at the moment. (Support for HighMem, swap files,
>  Nigel> asynchronous I/O, a nicer user interface, compression...).
> 
> Nigel is being modest and doesn't mention that the 2.4 version actually
> works, which is possibly its biggest advantage.

2.6.0-test3 swsusp should work, too, unless you have driver problem.
With ext2, ide and vesafb you should be able to suspend/resume
correctly.
That might not be practical for you, but should be
good enough for fixing drivers.
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

