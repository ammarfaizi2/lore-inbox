Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWBUWCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWBUWCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 17:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWBUWCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 17:02:53 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48600 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964871AbWBUWCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 17:02:53 -0500
Subject: Re: suspend2 review [was Re: Which is simpler? (Was Re:
	[Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)]
From: Lee Revell <rlrevell@joe-job.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: Pavel Machek <pavel@suse.cz>, Nigel Cunningham <nigel@suspend2.net>,
       Matthias Hensler <matthias@wspse.de>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
In-Reply-To: <20060220170537.GB33155@dspnet.fr.eu.org>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <200602200709.17955.nigel@suspend2.net> <20060219234212.GA1762@elf.ucw.cz>
	 <200602201210.58362.nigel@suspend2.net> <20060220124937.GB16165@elf.ucw.cz>
	 <20060220170537.GB33155@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Tue, 21 Feb 2006 17:02:45 -0500
Message-Id: <1140559365.2742.80.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 18:05 +0100, Olivier Galibert wrote:
> Pavel, if you mean that the userspace code will not be reviewed to
> standards the kernel code is, kill uswsusp _NOW_ before it does too
> much damage.  Unreliable suspend eats filesystems for breakfast.  The
> other userspace components of the kernels services are either optional
> (udev) or not that important (alsa).
> 

Why is sound less important than suspending, or networking, or any other
subsystem?  This is an insult to everyone who worked long and hard to
get decent sound support on Linux.

This attitude is why many distro's sound support is godawful.  Sometimes
I suspect they are testing on machines without speakers connected.

Lee

