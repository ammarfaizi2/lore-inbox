Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVDXUXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVDXUXr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 16:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbVDXUXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 16:23:47 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18828 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262403AbVDXUXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 16:23:33 -0400
Date: Sun, 24 Apr 2005 22:23:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsusp: misc cleanups [3/4]
Message-ID: <20050424202316.GD30088@elf.ucw.cz>
References: <200504232320.54477.rjw@sisk.pl> <200504232334.17343.rjw@sisk.pl> <20050423221826.GE1884@elf.ucw.cz> <200504241241.55411.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504241241.55411.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 24-04-05 12:41:55, Rafael J. Wysocki wrote:
> On Sunday, 24 of April 2005 00:18, Pavel Machek wrote:
> > Hi!
> > 
> > > The following patch cleans up whitespace in swsusp.c (a bit):
> > > - removes any trailing whitespace
> > > - adds spaces after if, for, for_each_pbe, for_each_zone etc., wherever
> > > necessary.
> > > 
> > > Please consider for applying.
> > 
> > Few hunks rejected, so I just applied those that work.
> 
> Sorry.  I did my best to be careful about this one, but without much success,
> apparently.

Well, you had no chance, and it is not your fault. My tree is not
published anywhere, and I already have some "crypto swsusp" and
similar stuff in....
							Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
