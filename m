Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbTL0Esj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 23:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265316AbTL0Esj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 23:48:39 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:57584 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S265315AbTL0Esi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 23:48:38 -0500
Subject: Re: 2.6.0 sound output - wierd effects
From: Stan Bubrouski <stan@ccs.neu.edu>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: azarah@nosferatu.za.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <2060000.1072483186@[10.10.2.4]>
References: <1080000.1072475704@[10.10.2.4]>
	 <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]>
	 <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]>
	 <1072482611.21020.71.camel@nosferatu.lan>  <2060000.1072483186@[10.10.2.4]>
Content-Type: text/plain
Message-Id: <1072500516.12203.2.camel@duergar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 26 Dec 2003 23:48:37 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-26 at 18:59, Martin J. Bligh wrote:
> I'll play with it - should narrow things down. However, fundamentally,
> it used to work in 2.5.74, and is broken as of test3 ... that strongly
> implies to me there's a kernel problem. I'd rather fix OSS emulation
> if possible, and save everybody migrating to 2.6 from this pain ... ;-)
> 

Please do, while it would be nice if OSS could be dropped altogether
there are a great many commercial and closed source apps that we all
need and only currently work with OSS.  For example flash player for
linux and real player, not to mention a myrid of open source apps that
have yet to move to ALSA support.  Right now its virtually impossible to
live with a kernel with no OSS for people like me who require use of
these apps on a daily basis.

-sb


> M.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

