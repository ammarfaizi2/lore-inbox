Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161181AbWBTVAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161181AbWBTVAF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 16:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161182AbWBTVAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 16:00:05 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12718 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161181AbWBTVAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 16:00:04 -0500
Date: Mon, 20 Feb 2006 21:59:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Sebastian K?gler <sebas@kde.org>,
       Matthias Hensler <matthias@wspse.de>, rjw@sisk.pl,
       kernel list <linux-kernel@vger.kernel.org>,
       suspend2-devel@lists.suspend2.net
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220205932.GD21557@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060220195155.GB7444@thunk.org> <20060220200807.GB21557@elf.ucw.cz> <200602210644.38538.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200602210644.38538.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 21-02-06 06:44:34, Nigel Cunningham wrote:
> Hi.
> 
> On Tuesday 21 February 2006 06:08, Pavel Machek wrote:
> > > Maybe you feel you are in a power position because your code happened
> > > to enter the kernel first, so you few you can have veto power over all
> > > other contenders.  It sometimes works that way, but only up to a
> >
> > Unfortunately, I do not need to veto suspend2. It is so complex that
> > it vetoes itself. Last time akpm stopped it, IIRC.
> 
> I'm going to let most of the last 8 hours' emails float by without reply, but 
> think I should comment here.

Thanks.

> I don't believe I've ever seen an email from Andrew stopping a merge, and I 
> shouldn't have, because I've never asked him to merge it. Being the 
> perfectionist that I am, I've sought to get it as stable, reliable and 
> comment-clean as I reasonably could before merging.

I believe I seen reply to that effect (saying "it is working and fast
is not enough for merge", or something like that.

Anyway, please Cc me on merge attempts...
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
