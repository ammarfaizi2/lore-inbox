Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266075AbUHYWYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266075AbUHYWYO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUHYWXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:23:49 -0400
Received: from ns0.cobite.com ([208.222.80.10]:6614 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id S266075AbUHYWU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:20:59 -0400
Date: Wed, 25 Aug 2004 18:20:59 -0400 (EDT)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@dhcp07.cobite.com
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc1
Message-ID: <Pine.LNX.4.58.0408251815560.1890@dhcp07.cobite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think the point is that the rc releases make all the difference.  Linus
is deciding what kernel to base the first rc against.  So:

2.6.9-rc1 has to be based on something, either 2.6.8 or 2.6.8.1 in this 
case.  

Whatever 2.6.9-rc1 is based on is what 2.6.9 will need to be based on
(I think).

And since, certainly, 2.6.8.2 may come out *after* 2.6.9-rc1, but *before*
2.6.9 final, it seems that 2.6.9-rc1 must be based on 2.6.8 to
prevent some weird 'shifting sands' type issues where no-one would know
what kernel to base their rc and final against.

My 2cents.


David
