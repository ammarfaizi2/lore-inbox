Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965161AbVIAOdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbVIAOdW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbVIAOdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:33:22 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:42373 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965161AbVIAOdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:33:21 -0400
Date: Thu, 1 Sep 2005 16:32:49 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Joe Korty <joe.korty@ccur.com>
cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: FW: [RFC] A more general timeout specification
In-Reply-To: <20050901135049.GB1753@tsunami.ccur.com>
Message-ID: <Pine.LNX.4.61.0509011610570.3743@scrub.home>
References: <F989B1573A3A644BAB3920FBECA4D25A042B030A@orsmsx407>
 <Pine.LNX.4.61.0509010136350.3743@scrub.home> <20050901135049.GB1753@tsunami.ccur.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Sep 2005, Joe Korty wrote:

> > When you convert a user time to kernel time you can
> > automatically validate
> 
> Kernel time sucks.  It is just a single clock, it may not have
> the attributes of the clock that the user really wished to use.

Wrong. The kernel time is simple and effective for almost all users.
We are talking about _timeouts_ here, what fancy "attributes" does that 
need that are just not overkill?

bye, Roman
