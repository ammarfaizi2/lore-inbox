Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbTHZDhg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 23:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTHZDhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 23:37:36 -0400
Received: from hendrix.ece.utexas.edu ([128.83.59.42]:22987 "EHLO
	hendrix.ece.utexas.edu") by vger.kernel.org with ESMTP
	id S262518AbTHZDhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 23:37:35 -0400
Date: Mon, 25 Aug 2003 22:37:30 -0500 (CDT)
From: "Hmamouche, Youssef" <youssef@ece.utexas.edu>
To: Christian Hesse <news@earthworm.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 hangs with pcmcia and linux-wlan
In-Reply-To: <200308260059.00737.news@earthworm.de>
Message-ID: <Pine.LNX.4.21.0308252234010.25458-100000@linux08.ece.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam,
	SpamAssassin (Disabled due to 10consecutive timeouts)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Out of curiosity, what happens when you remove the card? Does the system
come back to normal or does it stay in the same state?

Youssef

On Tue, 26 Aug 2003, Christian Hesse wrote:

> Hi,
> 
> I'm running kernels with pcmcia-cs-3.2.4 and linux-wlan-ng-0.2.1-pre11 (also 
> tried 0.2). With 2.4.22-rc3 to final the system hangs if I insert my LevelOne 
> WPC-0100 (Prism-II-base wlan), no output at all. Everything worked well up to 
> and including 2.4.22-rc2.
> 
> Regards,
>   Christian
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

