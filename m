Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbWILJQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWILJQS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 05:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbWILJQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 05:16:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5287 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964995AbWILJQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 05:16:18 -0400
Date: Tue, 12 Sep 2006 11:16:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Mark Gross <mgross@linux.intel.com>,
       Preece Scott-PREECE <scott.preece@motorola.com>,
       pm list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] cpufreq terminally broken [was Re: community PM requirements/issues and PowerOP]
Message-ID: <20060912091619.GA19482@elf.ucw.cz>
References: <20060911082025.GD1898@elf.ucw.cz> <b0623b9bb79afacc77cddc6e39c96b62@nomadgs.com> <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com> <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com> <20060911225617.GB13474@elf.ucw.cz> <20060912001701.GC14234@linux.intel.com> <20060912083328.GA19197@elf.ucw.cz> <acd2a5930609120210w7ee5a156s5fa5bbc59aeabad8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd2a5930609120210w7ee5a156s5fa5bbc59aeabad8@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-09-12 13:10:24, Vitaly Wool wrote:
> Pavel,
> 
> On 9/12/06, Pavel Machek <pavel@ucw.cz> wrote:
> >Can we at least try adding that, before deciding cpufreq is unsuitable
> >and starting new interface? I do not think issues are nearly as big as
> >you think.. (at user<->kernel interface level, anyway; you'll need big
> >changes under the hood).
> 
> who talks about user <-> kernel interface level changes at the moment?!

Eugeny?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
