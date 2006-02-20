Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161016AbWBTQcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbWBTQcz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbWBTQcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:32:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:909 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161022AbWBTQcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:32:41 -0500
Date: Mon, 20 Feb 2006 14:03:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthias Hensler <matthias@wspse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220130344.GB17627@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602091926.38666.nigel@suspend2.net> <20060209232453.GC3389@elf.ucw.cz> <200602110116.57639.sebas@kde.org> <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz> <20060220093911.GB19293@kobayashi-maru.wspse.de> <1140430269.3429.8.camel@mindpipe> <20060220102052.GC21817@kobayashi-maru.wspse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220102052.GC21817@kobayashi-maru.wspse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 20-02-06 11:20:52, Matthias Hensler wrote:
> Hi.
> 
> On Mon, Feb 20, 2006 at 05:11:09AM -0500, Lee Revell wrote:
> > On Mon, 2006-02-20 at 10:39 +0100, Matthias Hensler wrote:
> > > These "big changes" is something I have a problem with, since it
> > > means to delay a working suspend/resume in Linux for another
> > > "short-term" (so what does it mean: 1 month? six? twelve?). 
> > 
> > If you have a big problem with this then ask the developer why he
> > didn't submit it 1 or 6 or 12 months sooner, don't complain to the
> > kernel developers.
> 
> Well, that is up to Nigel, but he did spend a lot of time to make
> Suspend 2 clean and acceptable for the mainline first.

As I said.. Nigel is fixing small problems but not the big ones.

> I do not complain that the patch is not inserted as it is. I too see
> the problems and open issues. But that is nothing that cannot be solved.

Nigel is unviling to solve that. I pointed out 8000 lines of code
(>50% of his patch) that can better be done in userspace. I do not
think he's willing to address that.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
