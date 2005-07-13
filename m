Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbVGMVBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbVGMVBf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVGMU7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:59:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61895 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262713AbVGMTrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:47:49 -0400
Subject: Re: 2.6.13-rc2-mm2 -- include/linux/mtd/xip.h:68:25: error:
	asm/mtd-xip.h: No such file or directory
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, Miles Lane <miles.lane@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050713123434.3f607f0a.akpm@osdl.org>
References: <a44ae5cd05071308224b39aad5@mail.gmail.com>
	 <20050713123434.3f607f0a.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 20:46:25 +0100
Message-Id: <1121283986.12224.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 12:34 -0700, Andrew Morton wrote:
> I assume MTD_CFI should depend on ARM?

I believe it already does, in the git tree. Thomas asked Linus to pull
from that only about an hour ago.

-- 
dwmw2

