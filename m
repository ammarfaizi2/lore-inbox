Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUGBW07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUGBW07 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 18:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264998AbUGBW07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 18:26:59 -0400
Received: from palrel11.hp.com ([156.153.255.246]:63690 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264980AbUGBW05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 18:26:57 -0400
Date: Fri, 2 Jul 2004 15:26:55 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       David Gibson <hermes@gibson.dropbear.id.au>
Subject: Re: [PATCH] Update in-kernel orinoco drivers to upstream current CVS
Message-ID: <20040702222655.GA10333@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote :
> Dan Williams wrote:
> > Hi,
> > 
> > This patch is simply the fixed-up diff between the kernel's current
> > 0.13e version and the upstream 0.15rc1+ version from savannah CVS.
> > 0.15rc1 has been out for a couple months now and seems stable.
> 
> I'm desperately hoping that someone will split this up into multiple 
> patches...
> 
> 	Jeff

	David Gibson is the official maintainer of the Orinoco
driver. Pavel Roskin is the person that did most of the work on
0.15rc1+. I think it would be a nice idea to involve those two person
in such a discussion (therefore, cc'ed).
	The difference between 0.13e and 0.15rc1+ is not small. I
believe Pavel did a good job in splitting the various patches in small
pieces when adding them to the CVS, and David has tracked the kernel,
but reconciliating the two branches is no trivial matter.
	Jeff, does BitKeeper allow to merge patches at an earlier
point than the last version and reconciliate both branches ? That
might come handy.
	Good luck...

	Jean

