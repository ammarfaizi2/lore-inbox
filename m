Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbVHXVnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVHXVnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbVHXVnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:43:45 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:62982 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932288AbVHXVno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:43:44 -0400
Date: Wed, 24 Aug 2005 23:43:31 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] (5/5) I2C updates for 2.4.32-pre3
Message-Id: <20050824234331.5209042d.khali@linux-fr.org>
In-Reply-To: <20050818162509.GB6262@dmt.cnet>
References: <20050814151320.76e906d5.khali@linux-fr.org>
	<20050814171716.099b8f55.khali@linux-fr.org>
	<20050818162509.GB6262@dmt.cnet>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

> All of these seem to be cleanups/cosmetic enhancements rather than
> real bugfixes, except the ML address update.

Patches 1/5, 3/5 and 4/5 are typo fixes in documentation and comments.
5/5 however qualifies as (minor) bug fix IMHO, as missing newlines in
log messages will cause the next message's log level not to be
interpreted as such.

> As you know, we've been trying to reduce the scope of patch acceptance
> in v2.4.x to strictly necessary changes. 
> 
> Do any of these fall into this criteria? 

I sent you these patches because I thought they were worth applying,
obviously, so don't ask me. Apply them or discard them as you feel like,
it's really up to you, not me. From that, I'll know what kind of patches
are worth sending next time.

Thanks,
-- 
Jean Delvare
