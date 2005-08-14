Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbVHNN3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbVHNN3E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 09:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVHNN3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 09:29:04 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:56209 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932519AbVHNN3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 09:29:02 -0400
From: Willem Riede <wrlk@riede.org>
Subject: RE: NCQ support NVidia NForce4 (CK804) SATAII
Date: Sun, 14 Aug 2005 09:29:00 -0400
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Message-Id: <pan.2005.08.14.13.28.56.704434@riede.org>
References: <fa.psg95ip.1emqnop@ifi.uio.no>
Reply-To: wrlk@riede.org
To: linux-kernel@vger.kernel.org, "Allen Martin" <AMartin@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005 20:54:35 +0000, Allen Martin wrote:

> Likely the only way nForce4 NCQ support could be added under Linux would
> be with a closed source binary driver, and no one really wants that,
> especially for storage / boot volume.  We decided it wasn't worth the
> headache of a binary driver for this one feature.  Future nForce
> chipsets will have a redesigned SATA controller where we can be more
> open about documenting it.

That is disappointing. I was seriously considering a motherboard with your
chipset because of its impressive specifications, but now I have to
reconsider (I'm one of those folks that never bought an nVidia graphics
board due to the lack of open full-function driver). I _hate_ not being
able to use all features.

Any chance your company will reconsider? Are you in a position to make
that decision? Is there a VP I can write to (politely) to support the case?

I don't understand your reluctance in this case (I do for your graphics
processors) - it's not as if adding this function to sata_nv would
expose your crown jewels - you write yourself that next time you'd use a
different (better) interface...

Regards, Willem Riede.

