Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVHYFxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVHYFxN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVHYFxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:53:13 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:14546 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964845AbVHYFxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:53:12 -0400
Date: Thu, 25 Aug 2005 07:53:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc6-rt15 won't compile without HR-Timers
Message-ID: <20050825055359.GA26398@elte.hu>
References: <430CA8EB.3070105@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430CA8EB.3070105@cybsft.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> Ingo,
> 
> Without the attached patch 2.6.13-rc6-rt15 won't compile for me with 
> CONFIG_HIGH_RES_TIMERS not configured.

thanks, applied.

	Ingo
