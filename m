Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVDECVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVDECVs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 22:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVDECVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 22:21:48 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:41698 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261541AbVDECVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 22:21:44 -0400
Date: Tue, 5 Apr 2005 04:21:42 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: dtor_core@ameritech.net
Cc: romano@dea.icai.upco.es, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Touchpad does not work anymore
Message-ID: <20050405022142.GV10278@ens-lyon.fr>
References: <20050329110309.GA17744@pern.dea.icai.upco.es> <d120d5000503310715cbc917@mail.gmail.com> <20050331165007.GA29674@pern.dea.icai.upco.es> <200503311309.50165.dtor_core@ameritech.net> <40f323d0050401081423650536@mail.gmail.com> <d120d5000504010828152031a@mail.gmail.com> <20050401164321.GN10278@ens-lyon.fr> <d120d5000504010900142bed75@mail.gmail.com> <20050401172915.GO10278@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050401172915.GO10278@ens-lyon.fr>
User-Agent: Mutt/1.5.8i
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2005 at 07:29:15PM +0200, Benoit Boissinot wrote:
> On Fri, Apr 01, 2005 at 12:00:42PM -0500, Dmitry Torokhov wrote:
> > On Apr 1, 2005 11:43 AM, Benoit Boissinot <benoit.boissinot@ens-lyon.org> wrote:
> > > On Fri, Apr 01, 2005 at 11:28:05AM -0500, Dmitry Torokhov wrote:
> > > > On Apr 1, 2005 11:14 AM, Benoit Boissinot <bboissin@gmail.com> wrote:
> > > > > On Mar 31, 2005 8:09 PM, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > > > > > It works, too. Which one is the best one?
> > > > > > >
> > > > > I tried to boot with the 2 patches applied (and the patch which solves
> > > > > noresume) and now touchpad/touchpoint no longer works (with this
> > > > > kernel or with an older kernel).
> > > > >
> > > >
> > 
> > Should work... The patches come into play only when
> > suspending/resuming. So you are saying even with an old, unpatched
> > kernel ALS stopped working, right?
> >
> I did a suspend/resume with the patches applied. And yes it doesn't work
> with an old unpatched kernel.
> Detected in dmesg, but no movement.
> 
When i booted the laptop today, the touchpad did work. I suppose it
was an hardware problem or something like that.

Sorry for bothering you.

Thanks

Benoit

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
