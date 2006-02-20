Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWBTKLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWBTKLN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWBTKLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:11:13 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31893 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964828AbWBTKLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:11:11 -0500
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10]
	[Suspend2] Modules support.)
From: Lee Revell <rlrevell@joe-job.com>
To: Matthias Hensler <matthias@wspse.de>
Cc: Pavel Machek <pavel@suse.cz>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
In-Reply-To: <20060220093911.GB19293@kobayashi-maru.wspse.de>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <200602091926.38666.nigel@suspend2.net> <20060209232453.GC3389@elf.ucw.cz>
	 <200602110116.57639.sebas@kde.org>
	 <20060211104130.GA28282@kobayashi-maru.wspse.de>
	 <20060218142610.GT3490@openzaurus.ucw.cz>
	 <20060220093911.GB19293@kobayashi-maru.wspse.de>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 05:11:09 -0500
Message-Id: <1140430269.3429.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 10:39 +0100, Matthias Hensler wrote:
> > It is less work to port suspend2's features into userspace than to
> > make suspend2 acceptable to mainline. Both will mean big changes,
> and
> > may cause some short-term problems, but it will be less pain than
> > maintaining suspend2 forever. Please help with the former...
> 
> These "big changes" is something I have a problem with, since it means
> to delay a working suspend/resume in Linux for another
> "short-term" (so
> what does it mean: 1 month? six? twelve?). 

If you have a big problem with this then ask the developer why he didn't
submit it 1 or 6 or 12 months sooner, don't complain to the kernel
developers.

Lee

