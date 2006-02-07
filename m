Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWBGXvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWBGXvA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWBGXvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:51:00 -0500
Received: from atpro.com ([12.161.0.3]:40209 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1030296AbWBGXu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:50:59 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Tue, 7 Feb 2006 18:50:06 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, Lee Revell <rlrevell@joe-job.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060207235006.GE5341@voodoo>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Nigel Cunningham <nigel@suspend2.net>,
	Lee Revell <rlrevell@joe-job.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1139282017.2041.44.camel@mindpipe> <20060207093737.GC1742@elf.ucw.cz> <200602071940.53843.nigel@suspend2.net> <20060207230245.GD2753@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207230245.GD2753@elf.ucw.cz>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/06 12:02:45AM +0100, Pavel Machek wrote:
> Hi!
> Ugh?
> 
> Lee is a programmer. He wants faster swsusp, and improving uswsusp is
> currently best way to get that. It may be alpha/beta quality, but
> someone has to start testing, and Lee should be good for that (played
> with realtime kernels etc...). Actually it is in good enough state
> that I'd like non-programmers to test it, too.
> 
> And yes, I'm a maintainer, and that means I have to reject bad
> patches from time to time, too.
> 								Pavel

Best is a subjective term, I would say the 'best' way to get a swsusp
implementation that can save all of his caches and still suspend/resume
faster would be to just apply the Suspend2 patches and get on with
whatever he'd rather be doing since the work's already been done.

Jim.
