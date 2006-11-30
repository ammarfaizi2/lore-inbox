Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936305AbWK3NXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936305AbWK3NXM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 08:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936364AbWK3NXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 08:23:11 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:65503 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S936305AbWK3NXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 08:23:10 -0500
Date: Thu, 30 Nov 2006 22:23:04 +0900 (JST)
Message-Id: <20061130.222304.41197952.anemo@mba.ocn.ne.jp>
To: tr@newtec.dk
Cc: a.zummo@towertech.it, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: ds1743 support
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200611300812.02261.tr@newtec.dk>
References: <200611300812.02261.tr@newtec.dk>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 08:12:02 +0100, Torsten Ertbjerg Rasmussen <tr@newtec.dk> wrote:
> The real time clocks ds1742 and ds1743 differs only in the size of the nvram. 
> This patch changes the existing ds1742 driver to support also ds1743. The 
> main change is that the nvram size is determined from the resource attached 
> to the device. 
> 
> This patch applies to and have been tested with 2.6.19-rc5 and 2.6.19-rc6.
> 
> The patch have benefitted from suggestions from Atsushi Nemeto, who is the 
> author of the ds1742 driver. 

OK with DS1742.

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
Atsushi Nemoto
