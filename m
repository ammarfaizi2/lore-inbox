Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWBGEkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWBGEkc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 23:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWBGEkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 23:40:32 -0500
Received: from mail.gmx.net ([213.165.64.21]:53726 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964970AbWBGEkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 23:40:31 -0500
Date: Tue, 7 Feb 2006 05:40:30 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <200602061617.12713.jbarnes@virtuousgeek.org>
Subject: Re: man-pages-2.22 is released
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <16940.1139287230@www031.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Monday, February 6, 2006 2:59 pm, Michael Kerrisk wrote:
> > > Wouldn't it be easier for you to keep them up to date if sections 2,
> > > 4, and parts of 5 were included in the kernel source tree? 
> > > Documentation updates could be enforced as part of the patch
> > > process--all you'd have to do is NAK patches that modified userland
> > > interfaces if they didn't contain documentation updates (and I'm
> > > sure others would help you with that task).
> >
> > Life is not so simple, as I think we discussed when you made
> > a similar comment after my man-pages-2.08 release.  Maybe the
> > system can be improved still.  Currently Andrew Morton is being
> > rather good about CCing me on patches that are likely to need
> > man-pages changes.  (Thanks Andrew!)
> 
> Yeah, vigilance is key; maybe I'm wrong that putting the kernel stuff 
> into the kernel tree would help, but it's worth a try, don't you 
> think? :)

There is no simple solution to this problem, but I will
give it some thought one day...

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
