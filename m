Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269944AbUJSWXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269944AbUJSWXd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269949AbUJSWUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:20:22 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:6546 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S269933AbUJSWPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:15:51 -0400
From: Russell Miller <rmiller@duskglow.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: 2.6.9 DRM compile problem
Date: Tue, 19 Oct 2004 17:19:34 -0500
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200410191613.35691.rmiller@duskglow.com> <9e4733910410191514db82abc@mail.gmail.com>
In-Reply-To: <9e4733910410191514db82abc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410191719.35057.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 October 2004 17:14, Jon Smirl wrote:
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> # CONFIG_CLEAN_COMPILE is not set
> CONFIG_BROKEN=y
> CONFIG_BROKEN_ON_SMP=y
>
> Gamma is marked BROKEN

Hmm.  I didn't see an option to turn it off, though I will look again.

And how do I find out which are broken so I don't post to this list and make 
an @$$ out of myself again?

Thanks.

--Russell

-- 

Russell Miller - rmiller@duskglow.com - Le Mars, IA
Duskglow Consulting - Helping companies just like you to succeed for ~ 10 yrs.
http://www.duskglow.com - 712-546-5886
