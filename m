Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279708AbRKAUR6>; Thu, 1 Nov 2001 15:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279700AbRKAURs>; Thu, 1 Nov 2001 15:17:48 -0500
Received: from adsl-216-102-163-254.dsl.snfc21.pacbell.net ([216.102.163.254]:19854
	"EHLO windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S279711AbRKAURj>; Thu, 1 Nov 2001 15:17:39 -0500
Date: Thu, 1 Nov 2001 12:13:56 -0800 (PST)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@windmill.gghcwest.com>
To: Nick LeRoy <nleroy@cs.wisc.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: on exit xterm  totally wrecks linux 2.4.11 to 2.4.14-pre6
 (unkillable processes)
In-Reply-To: <200111012007.fA1K7AG10327@schroeder.cs.wisc.edu>
Message-ID: <Pine.LNX.4.33.0111011212220.27747-100000@windmill.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Nov 2001, Nick LeRoy wrote:

> Marked experiment, for now.  What about when it's no longer "experimental"?
> Configuring a kernel to enable such a feature should *not* break
> applications, especially something as prolific as xterm.

Are you sure you know what you are talking about?  Devfs causes this
problem because of a defect, not by design.  It is marked experimental
because it's loaded with such defects.  Don't use it until the
experimental tag is removed, if you are not prepared for some malfunction.

-jwb

