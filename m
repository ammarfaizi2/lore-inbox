Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWCFTwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWCFTwB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbWCFTwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:52:00 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:23483 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1752409AbWCFTv6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:51:58 -0500
Date: Mon, 6 Mar 2006 20:48:21 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: de2104x: interrupts before interrupt handler is registered
Message-ID: <20060306194821.GA15728@electric-eye.fr.zoreil.com>
References: <20060305180757.GA22121@deprecation.cyrius.com> <20060305185948.GA24765@electric-eye.fr.zoreil.com> <20060306143512.GI23669@deprecation.cyrius.com> <20060306191706.GA6947@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306191706.GA6947@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Michlmayr <tbm@cyrius.com> :
[...]
> There's another interrupt related bug in the driver, though.  I
> sometimes get a kernel panic when rsycing several 100 megs of data
> across the LAN.  A picture showing the call trace can be found at
> http://www.cyrius.com/tmp/de2104x_panic.jpg

Can you publish the .config ?

-- 
Ueimor
