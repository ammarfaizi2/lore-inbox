Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWBFN7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWBFN7q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 08:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWBFN7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 08:59:46 -0500
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:49805 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S932118AbWBFN7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 08:59:45 -0500
Subject: Re: [Fwd: [PATCH 8/12] LED: Add LED device support for ixp4xx
	devices]
From: Arjan van de Ven <arjan@infradead.org>
To: Dan McDonald <dan@vkl.ath.cx>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0602052255110.10566@dan>
References: <1139154997.14624.20.camel@localhost.localdomain>
	 <20060205192025.4006a554.akpm@osdl.org>
	 <1139202455.3131.56.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0602052255110.10566@dan>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 14:56:35 +0100
Message-Id: <1139234195.3131.81.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-05 at 23:00 -0800, Dan McDonald wrote:
> 
> On Mon, 6 Feb 2006, Arjan van de Ven wrote:
> 
> > On Sun, 2006-02-05 at 19:20 -0800, Andrew Morton wrote:
> >> Richard Purdie <rpurdie@rpsys.net> wrote:
> >>>
> >>> +MODULE_AUTHOR("John Bowler <jbowler@acm.org>");
> >>> +MODULE_DESCRIPTION("IXP4XX GPIO LED driver");
> >>> +MODULE_LICENSE("MIT");
> >>
> >> MIT license is unusual.  There's one other file in the kernel which uses it
> >> and that's down in MTD where nobody dares look.
> >>
> >> I don't know whether MIT is GPL-compatible-for-kernel-purposes or not.  Help.
> >
> > would be really nice if the author would at least dual license it under
> > the GPL as well (and thus also granting the patent rights if any)
> 
> It would be really nice, but that doesn't make the rights to any patents 
> granted unless 'GPLv2 or any later version' is explicitly specified. The 
> default GPL license is v2 and only v2. There was a bug thread about this 
> on LKML earlier.

wrong. v2 already is a statement that the author doesn't have patents on
the code, or alternatively that the author has granted you the patent
rights and will not sue you for using the code. it's also a statement
that the author doesn't have patent licenses from 3rd parties that
he/she cannot sublicense.

v3 clarifies and expands on this most likely, but v2 already offers
basic patent trap protection.


