Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267810AbUIGKTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267810AbUIGKTI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 06:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267823AbUIGKTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 06:19:08 -0400
Received: from znx208-2-156-007.znyx.com ([208.2.156.7]:32517 "EHLO
	lotus.znyx.com") by vger.kernel.org with ESMTP id S267810AbUIGKSq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 06:18:46 -0400
Subject: Re: [PATCH 2.6] watch64: generic variable monitoring system
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <200409051219.47590.jeffpc@optonline.net>
References: <200409031307.01240.jeffpc@optonline.net>
	 <200409031744.32970.jeffpc@optonline.net>
	 <1094303999.1633.116.camel@jzny.localdomain>
	 <200409051219.47590.jeffpc@optonline.net>
Organization: jamalopolis
Message-Id: <1094460391.1151.26.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Sep 2004 06:18:11 -0400
X-MIMETrack: Itemize by SMTP Server on Lotus/Znyx(Release 5.0.11  |July 24, 2002) at 09/07/2004
 03:20:09 AM,
	Serialize by Router on Lotus/Znyx(Release 5.0.11  |July 24, 2002) at 09/07/2004
 03:20:16 AM,
	Serialize complete at 09/07/2004 03:20:16 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 2004-09-05 at 12:19, Jeff Sipek wrote:
> On Saturday 04 September 2004 09:19, jamal wrote:
> > I have a feeling this was discussed somewhere(other than netdev) and i
> > missed it. Why isnt this watch64 being done in user space?
> 
> There was a discussion about 64-bit network statistics about a year ago on 
> lkml.

Sorry unsubscribed from lkml since summer of '94. [net related
discussions should really happen on netdev].

> watch64 is a generic so that anyone in the kernel can use it.

Ok - so why does this have to be in the kernel?

cheers,
jamal

