Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946310AbWJ0LYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946310AbWJ0LYl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946408AbWJ0LYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:24:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26346 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1946310AbWJ0LYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:24:40 -0400
Date: Fri, 27 Oct 2006 13:23:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Radim =?utf-8?B?THXFvmE=?= <xluzar00@stud.fit.vutbr.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: suspend to disk -> resume -> X with DRI extension on R100 chips hangs
Message-ID: <20061027112316.GA8095@elf.ucw.cz>
References: <453F01CF.2040106@eva.fit.vutbr.cz> <200610252103.47886.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200610252103.47886.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Wednesday, 25 October 2006 08:18, Radim Luža wrote:
> > Good morning
> > 
> > I noticed following problem:
> > After resuming from suspend to disk Xorg with DRI switched on hangs. 
> > System is not affected by Xorg hang. If I login via SSH I can kill X 
> > server and start it again - with same result. X server hangs even after 
> > I suspend from text mode with X not running and with unloaded modules 
> > radeon and drm and resume then and try to start X server. With DRI 
> > switched off in xorg.conf X resumes correctly.
> 
> Well, I think you'll need to file a bug repart at http://bugzilla.kernel.org
> (please add rjwysocki@sisk.pl to the Cc list).

Actually, I'm not sure if this is not an X problem...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
