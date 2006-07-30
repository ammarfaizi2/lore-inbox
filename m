Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWG3Kug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWG3Kug (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 06:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWG3Kug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 06:50:36 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:34056 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932255AbWG3Kug
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 06:50:36 -0400
Date: Sun, 30 Jul 2006 12:50:33 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Sylvain Meyer <sylvain.meyer@worldonline.fr>
Cc: Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org,
       Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH] intelfbhw.c: intelfbhw_get_p1p2 defined but not used
Message-Id: <20060730125033.efb0d87e.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.64.0607060154130.2027@gentoo.warudkars.net>
References: <Pine.LNX.4.64.0607060154130.2027@gentoo.warudkars.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> intelfbhw_get_p1p2 is used only if REGDUMP is defined - compile it in only 
> if REGDUMP is defined - one less compiler warning.
> 
> Patch against 2.6.18-rc1.

Can we please have this patch merged in Linus' tree now?

Thanks,
-- 
Jean Delvare
