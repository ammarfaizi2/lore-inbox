Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbWCFU3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbWCFU3V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 15:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWCFU3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 15:29:21 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:16656 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751492AbWCFU3U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 15:29:20 -0500
Date: Mon, 6 Mar 2006 20:29:07 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: de2104x: interrupts before interrupt handler is registered
Message-ID: <20060306202907.GB8747@deprecation.cyrius.com>
References: <20060305180757.GA22121@deprecation.cyrius.com> <20060305185948.GA24765@electric-eye.fr.zoreil.com> <20060306143512.GI23669@deprecation.cyrius.com> <20060306191706.GA6947@deprecation.cyrius.com> <20060306194821.GA15728@electric-eye.fr.zoreil.com> <20060306195953.GB10703@deprecation.cyrius.com> <20060306202330.GB15728@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306202330.GB15728@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Francois Romieu <romieu@fr.zoreil.com> [2006-03-06 21:23]:
> > http://www.cyrius.com/tmp/config-2.6.16-rc5-486
> > By the way, I'm getting the following messages in dmesg:
> netconsole appears enabled. Do you use it ?

It's a standard Debian kernel config so pretty much everything is
enabled as a module.  I didn't use netconsole.
-- 
Martin Michlmayr
http://www.cyrius.com/
