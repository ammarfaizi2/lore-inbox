Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277112AbRJQTeg>; Wed, 17 Oct 2001 15:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277094AbRJQTe1>; Wed, 17 Oct 2001 15:34:27 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:52356 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S277097AbRJQTeS>;
	Wed, 17 Oct 2001 15:34:18 -0400
Message-ID: <3BCDDD4F.99F88B47@candelatech.com>
Date: Wed, 17 Oct 2001 12:34:39 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gerhard Mack <gmack@innerfire.net>
CC: Christoph Lameter <christoph@lameter.com>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <Pine.LNX.4.10.10110171126480.5821-100000@innerfire.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerhard Mack wrote:
> 
> On Tue, 16 Oct 2001, Christoph Lameter wrote:
> 
> > On Wed, 17 Oct 2001, Keith Owens wrote:
> >
> > > On Tue, 16 Oct 2001 21:59:03 -0700 (PDT),
> > > Christoph Lameter <christoph@lameter.com> wrote:
> > > >The loop driver is not GPL compatible???
> > >
> > > In 2.4.11 loop.c has no MODULE_LICENCE.  It will take a while for all
> > > modules to be correctly flagged.
> >
> > Then do not output such a message. This is not M$ windows.
> >
> And how do you expect them to find all of the modules that don't have
> MODULE_LICENCE if they can't see an indicator in the boot messages?
> 

Can't you just make it a warning for now and give ppl a few months to
clean things up?  It strikes me that any code that serves no technical
purpose and actively decreases functionality of the kernel is highly
suspect.  Or maybe even wait till 2.5...

Ben

>         Gerhard
> 
> --
> Gerhard Mack
> 
> gmack@innerfire.net
> 
> <>< As a computer I find your faith in technology amusing.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
