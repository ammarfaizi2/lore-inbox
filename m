Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWI2Kvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWI2Kvp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 06:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWI2Kvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 06:51:45 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:55223 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751223AbWI2Kvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 06:51:44 -0400
Date: Fri, 29 Sep 2006 14:51:20 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Samuel Tardieu <sam@rfc1149.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Subject: Re: [ACRYPTO] New asynchronous crypto layer (acrypto) release.
Message-ID: <20060929105118.GA20194@2ka.mipt.ru>
References: <20060928120826.GA18063@2ka.mipt.ru> <87wt7nm0x5.fsf@willow.rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <87wt7nm0x5.fsf@willow.rfc1149.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 29 Sep 2006 14:51:27 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 12:17:58PM +0200, Samuel Tardieu (sam@rfc1149.net) wrote:
> >>>>> "Evgeniy" == Evgeniy Polyakov <johnpol@2ka.mipt.ru> writes:
> 
> Evgeniy> Hello.  I'm pleased to announce asynchronous crypto layer
> Evgeniy> (acrypto) [1] release for 2.6.18 kernel tree. Acrypto allows
> Evgeniy> to handle crypto requests asynchronously in hardware.
> 
> Would userspace programs benefit from this patch? In particular, would
> OpenSSL get better performances on Via nehemiah CPUs or does it need
> to be patched?

Userspace supports Via Nehemiah CPUs crypto engine quite for a long time
without any external patching.

>   Sam
> -- 
> Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/

-- 
	Evgeniy Polyakov
