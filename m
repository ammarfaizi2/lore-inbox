Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268476AbTGSQHy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 12:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270057AbTGSQHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 12:07:54 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:59145
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S268476AbTGSQHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 12:07:53 -0400
Date: Sat, 19 Jul 2003 09:23:04 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Eugene Teo <eugene.teo@eugeneteo.net>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH] O7int for interactivity
Message-ID: <20030719162304.GA1059@matchmail.com>
Mail-Followup-To: Eugene Teo <eugene.teo@eugeneteo.net>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
	Davide Libenzi <davidel@xmailserver.org>
References: <200307190210.49687.kernel@kolivas.org> <20030718230717.GG2289@matchmail.com> <20030719034059.GE10120@eugeneteo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030719034059.GE10120@eugeneteo.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 11:40:59AM +0800, Eugene Teo wrote:
> <quote sender="Mike Fedyk">
> > On Sat, Jul 19, 2003 at 02:10:49AM +1000, Con Kolivas wrote:
> > > Here is an update to my Oint patches for 2.5/6 interactivity. Note I will be 
> > > away for a week so bash away and abuse this one lots and when I get back I can 
> > > see what else needs doing. Note I posted a preview earlier but this is the formal
> > > O7 patch (check the datestamp which people hate in the naming of my patches).
> > > I know this is turning into a marathon effort but... as you're all probably aware
> > > there is nothing simple about tuning this beast. Thanks to all the testers and
> > > people commenting; keep it coming please.
> > 
> > Is this on top of 06 or 06.1?
> 
> His patches are usually on top of the previous patch,
> so if you applied O6int, apply O6.1int on it, then O7int on O6.1int.
> But do read his readme file when you download it.

Yeah, I didn't even go to his web site.  I've been taking his patches sent
through email, saving it to a file, and running that through patch... :-D
