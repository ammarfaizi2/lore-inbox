Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWBRMFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWBRMFa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWBRMFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:05:30 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:31159
	"EHLO pcpool00.mathematik.uni-freiburg.de") by vger.kernel.org
	with ESMTP id S1751128AbWBRMFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:05:30 -0500
Date: Sat, 18 Feb 2006 13:05:29 +0100
From: "Bernhard R. Link" <brlink@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] register sysfs device for lp devices
Message-ID: <20060218120528.GA30567@pcpool00.mathematik.uni-freiburg.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060217113836.GA26254@pcpool00.mathematik.uni-freiburg.de> <20060217094326.0ae35311@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217094326.0ae35311@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Hemminger <shemminger@osdl.org> [060217 19:17]:
> O
> > +	parport_set_dev (p, &dev->dev);
> >  	parport_announce_port (p);
> 
> Why does the parallel port code use a different whitespace style than
> the rest of the kernel. It is incorrect and potentially confusing to
> put a blank between the function name and the arguments. It is like
> reading, english, with commas in the wrong spot.

What is the policy for patches of such code? Should patches adhere to
the style of the specific file or that of the whole kernel?

Hochachtungsvoll,
	Bernhard R. Link
