Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWA2H61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWA2H61 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 02:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWA2H61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 02:58:27 -0500
Received: from tachyon.quantumlinux.com ([64.113.1.99]:21949 "EHLO
	tachyon.quantumlinux.com") by vger.kernel.org with ESMTP
	id S1750740AbWA2H6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 02:58:11 -0500
Date: Sat, 28 Jan 2006 23:58:49 -0800 (PST)
From: Chuck Wolber <chuckw@quantumlinux.com>
X-X-Sender: chuckw@localhost.localdomain
To: "Justin M. Forbes" <jmforbes@linuxtx.org>
cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 0/6] 2.6.14.7 -stable review
In-Reply-To: <20060129044307.GA23553@linuxtx.org>
Message-ID: <Pine.LNX.4.63.0601282345090.7205@localhost.localdomain>
References: <20060128021749.GA10362@kroah.com> <Pine.LNX.4.63.0601282028210.7205@localhost.localdomain>
 <20060129044307.GA23553@linuxtx.org>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jan 2006, Justin M. Forbes wrote:

> On Sat, Jan 28, 2006 at 08:30:25PM -0800, Chuck Wolber wrote:
> > 
> > Please correct me if I'm wrong here, but aren't we supposed to stop doing 
> > this for the 2.6.14 release now that 2.6.15 is out?
> 
> I don't see a problems with doing additional stable releases for any 
> kernel, I just wouldn't commit to supporting any specific number of 
> releases.  Basically if people send enough patches to warrant a 
> review/release there is obviously some interest.  What is the harm?

No harm at all, and that settles it for me then. I like the idea of having 
a demand based release system. If no patches arrive, no releases go out.

..Chuck..


-- 
http://www.quantumlinux.com
 Quantum Linux Laboratories, LLC.
 ACCELERATING Business with Open Technology

 "The measure of the restoration lies in the extent to which we apply
  social values more noble than mere monetary profit." - FDR
