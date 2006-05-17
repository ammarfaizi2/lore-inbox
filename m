Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWEQWeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWEQWeS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWEQWeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:34:18 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:64130 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1750742AbWEQWeR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:34:17 -0400
Date: Wed, 17 May 2006 15:36:01 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH 00/22] -stable review
Message-ID: <20060517223601.GI2697@moss.sous-sol.org>
References: <20060517221312.227391000@sous-sol.org> <Pine.LNX.4.64.0605171522050.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605171522050.10823@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds (torvalds@osdl.org) wrote:
> 
> 
> On Wed, 17 May 2006, Chris Wright wrote:
> >
> > This is the start of the stable review cycle for the 2.6.16.17 release.
> > There are 22 patches in this series, all will be posted as a response to
> > this one.
> 
> I notice that none of the patches have authorship information.
> 
> Has that always been true and I just never noticed before?

It has always been that way with my script, I think Greg's as well.  Of
course, it's in the patch, and goes into git with proper authorship.

> Could you make your review script add the proper "From:" to the top of the 
> body of the email so that that is visible during review too?

Sure, that should be doable...SMOS (small matter of scripting ;-)

thanks,
-chris
