Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWBBLvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWBBLvZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWBBLvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:51:25 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:32531 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1750912AbWBBLvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:51:24 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: GPL V3 and Linux - Dead Copyright Holders
Date: Thu, 2 Feb 2006 03:50:30 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEKMJNAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
In-Reply-To: <87mzha85sc.fsf@babel.ls.fi.upm.es>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 02 Feb 2006 03:47:12 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 02 Feb 2006 03:47:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 1.- Distribute a kernel with some DRM built-in under the GPL.
>
> 2.- Claim that such kernel is an effective technological measure to
>     protect copyright.
>
> 3.- You are no longer free to modify that kernel, (removing the DRM
>     module) or you can be sued under the DMCA, for circumventing an
>     effective technological measure. It doesn't matter in what
>     hardware are you going to run such kernel. The DMCA implicitly
>     imposes an additional restriction to the GPL, but as the
>     restriction is not imposed directly by the copyright owner, but by
>     the law, it's OK as far the GPL is concerned.

	You can't do that. The restriction is not imposed by the law, it's imposed
by the the copyright owner the instant he added an effective technological
measure to protect copyright to the GPL'd code.

	GPLv2 code *cannot* contain any license or copyright enforcement
mechanisms. It can contain code that appears to be such a thing only
provided that the legal position is not that it's such a thing.

	For example, you can make a kernel that will refuse to load kernel modules
that aren't licensed under the GPL. But you cannot prevent anyone from
removing that logic if they want to.

	*If* you add a license enforcement mechanism to some code or *you* declare
that existing code is such a mechanism, then *you* are imposing the
additional restrictions.

	The idea of it being imposed "directly by the copyright owner" is just
something you made up. The GPL does not distinguish between direct and
indirect impositions. In fact, it goes out of its way to make it impossible
to indirectly impose additional conditions. See, for example, section 7.

> The point is that it is not the copyright holder who is imposing the
> restrictions, is the law. For example, the law may impose some export
> restrictions, would that void the GPL?

	Again, see section 6. If you cannot allow unrestricted modification, then
you cannot comply with the GPL. If you cannot comply with the GPL, then you
do not get the rights the GPL might give you. If you need the GPL to give
you the right to distribute, and you cannot comply with the GPL (even though
it's through no fault of your own), then you cannot distribute.

	DS


