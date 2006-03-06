Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752010AbWCFUz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbWCFUz6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 15:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbWCFUz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 15:55:58 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:55775 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751896AbWCFUz5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 15:55:57 -0500
Date: Mon, 6 Mar 2006 21:54:06 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: de2104x: interrupts before interrupt handler is registered
Message-ID: <20060306205406.GC15728@electric-eye.fr.zoreil.com>
References: <20060305180757.GA22121@deprecation.cyrius.com> <20060305185948.GA24765@electric-eye.fr.zoreil.com> <20060306143512.GI23669@deprecation.cyrius.com> <20060306191706.GA6947@deprecation.cyrius.com> <20060306194821.GA15728@electric-eye.fr.zoreil.com> <20060306195953.GB10703@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306195953.GB10703@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Michlmayr <tbm@cyrius.com> :
[...]
> By the way, I'm getting the following messages in dmesg:
> 
> eth0: tx err, status 0x7fffb002

Tx underrun.

Is there anything which could induce a noticeable load on the PCI bus ?

-- 
Ueimor

