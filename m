Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTJAR1f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 13:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTJAR1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 13:27:35 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:20636 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262439AbTJAR1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 13:27:34 -0400
Date: Wed, 1 Oct 2003 19:27:23 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dan <overridex@punkass.com>
Cc: Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] 2.6: joydev is too eager claiming input devices
Message-ID: <20031001172723.GA32735@ucw.cz>
References: <1064459037.19555.3.camel@nazgul.overridex.net> <200309250012.48522.dtor_core@ameritech.net> <20030924232912.7e41d9f9.akpm@osdl.org> <1064995829.14483.8.camel@nazgul.overridex.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064995829.14483.8.camel@nazgul.overridex.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 04:10:29AM -0400, Dan wrote:
> On Thu, 2003-09-25 at 02:29, Andrew Morton wrote:
> > Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > >
> > > Could you please try the following patch (it is incremental against the 
> > >  previous one and should apply to the -mm)
> > 
> > I ran that patch[1] past Vojtech yesterday and he then fixed the problem
> > which it was addressing by other means within his tree.
> > 
> > So what we should do is to ask Vojtech to share that change with us so Dan
> > can test it, please.
> > 
> > 
> > [1] ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5/2.6.0-test5-mm4/broken-out/joydev-exclusions.patch
> > 
> 
> Hi again,
> 
> I'm using 2.6.0-test6 right now with Dmitry's fix and it works fine,
> still waiting for Vojtech's code to test out -Dan

It's in test6. Does test6 work fine without Dmitry's fix?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
