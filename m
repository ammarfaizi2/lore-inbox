Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266103AbRF2OvE>; Fri, 29 Jun 2001 10:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266101AbRF2Ouq>; Fri, 29 Jun 2001 10:50:46 -0400
Received: from out-mx1.crosswinds.net ([209.208.163.38]:21278 "HELO
	out-mx1.crosswinds.net") by vger.kernel.org with SMTP
	id <S266103AbRF2Oue>; Fri, 29 Jun 2001 10:50:34 -0400
Date: Fri, 29 Jun 2001 16:49:42 +0200
From: Patrick Mauritz <oxygene2k1@crosswinds.net>
To: linux-kernel@vger.kernel.org
Subject: Re: A Possible 2.5 Idea, maybe?
Message-ID: <20010629164942.B21707@crosswinds.net>
In-Reply-To: <Pine.LNX.4.33.0106290753340.25959-100000@biglinux.tccw.wku.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0106290753340.25959-100000@biglinux.tccw.wku.edu>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2001 at 08:17:25AM -0500, Brent D. Norris wrote:
> Instead of forking the kernel or catering only to one group, instead why
> not try this:  Using the new CML2 tools and rulesets, make it possible to
> have the kernel configured for the type of job it will be doing?  Just
> like CML2 asks our CPU type (i386, alpha, althon ...) and then goes out
> and configures options for that, have it ask people "Is your machine a
> server, workstation, embedded/handheld?" and configure things in the
> kernel like the VM, bootup and others to optimize it for that job type?
that could be the "easy == end-user" setup
why can't there be two (possibly similar but tweaked) VMs (and other stuff as well)
be in the source so everyone has to choose exactly one for his kernel?

patrick mauritz
-- 
,------------------------------------------------------------------------.
>            Fighting for peace is like fucking for virginity            <
|------------------------------------------------------------------------|
>        The Forthcoming OpenBIOS | www.freiburg.linux.de/openbios       <
`------------------------------------------------------------------------'
          because light travels faster than sound, some people
           appear to be intelligent, until you hear them speak.
