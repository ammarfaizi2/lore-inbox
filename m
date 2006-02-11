Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWBKBNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWBKBNI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 20:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWBKBNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 20:13:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5610 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751341AbWBKBNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 20:13:05 -0500
Date: Sat, 11 Feb 2006 02:12:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian =?iso-8859-1?Q?K=FCgler?= <sebas@kde.org>
Cc: suspend2-devel@lists.suspend2.net, Nigel Cunningham <nigel@suspend2.net>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060211011222.GB2174@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602091926.38666.nigel@suspend2.net> <20060209232453.GC3389@elf.ucw.cz> <200602110116.57639.sebas@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200602110116.57639.sebas@kde.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 11-02-06 01:16:51, Sebastian Kügler wrote:
> On Saturday 11 February 2006 00:35, Pavel Machek wrote:
> > So another flamewar is over, good. I even received one apology ;-),
> > and probably should have sent some apologies, too...
> [...]
> > version. How you could help?
> >
> > * testing is useful at this point. Few confirmations that it works in
> > different configurations would make us feel warm and fuzzy.
> >
> > * documentation improvements, and small scripts. Having script that
> > prepares initrd would be nice, for example.
> >
> > * having someone to maintain suspend.sf.net web pages / release CVS
> > snapshot as package would help, too.
> >
> > * userspace code improvements. Encryption, LZW and graphical progress
> > should be reasonably easy to do. There's some tricky stuff, if you
> > prefer -- support for swap files and normal files would help,
> > too. Plus I guess everyone has their favourite feature...
> 
> That all makes sense.
> 
> To make uswsusp a success you need it tested [T], supporting scripts [S], 
> someone [B] who puts work in the webpages [W] with decent documentation [D], 
> and a bunch of spiffy features [F].
> 
> [T] * http://wiki.suspend2.net/FeatureUserRegister 
>     * http://www.suspend2.net/lists
> [S] http://www.suspend2.net/downloads/all/hibernate-script-1.12.tar.gz
> [B] Bernard Blackham, b-swweb@blackham.com.au
> [W] http://www.suspend2.net
> [D] * http://www.suspend2.net/links
>     * http://www.suspend2.net/HOWTO
>     * http://www.suspend2.net/FAQ
> [F] http://www.suspend2.net/features
> 
> I, as a contributors to suspend2, have been working on all that stuff for 
> about two-and-a-half years, and it makes me really sad to see that
> someone in 

If you think current situation makes me happy... think again.

> a position to make a decision towards progress wants to start that whole 
> process all over, rather than acknowledging the existance of a
> technical 

We don't have to start all over. It should be possible to port most of
suspend2 into userspace...
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
