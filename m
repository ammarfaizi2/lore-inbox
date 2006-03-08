Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWCHDWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWCHDWe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 22:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWCHDWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 22:22:34 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:38927 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S932422AbWCHDWd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 22:22:33 -0500
Date: Wed, 8 Mar 2006 03:22:19 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: de2104x: interrupts before interrupt handler is registered
Message-ID: <20060308032219.GD8094@deprecation.cyrius.com>
References: <20060305180757.GA22121@deprecation.cyrius.com> <20060305185948.GA24765@electric-eye.fr.zoreil.com> <20060306143512.GI23669@deprecation.cyrius.com> <20060306191706.GA6947@deprecation.cyrius.com> <20060306211745.GD15728@electric-eye.fr.zoreil.com> <20060307051152.GA1244@deprecation.cyrius.com> <20060308001556.GA9362@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308001556.GA9362@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Francois Romieu <romieu@fr.zoreil.com> [2006-03-08 01:15]:
> netdev watchdog events appear in the dmesg of the patched driver.
> The driver survived it. So I'd say that the patch does its job.
> 
> OTOH, if you ever saw the unpatched driver survive this event, yell
> now.

No, I've never seen the unpatched driver survive.
-- 
Martin Michlmayr
http://www.cyrius.com/
