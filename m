Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265192AbTLKSRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 13:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbTLKSRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 13:17:33 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:27520 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S265192AbTLKSRc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 13:17:32 -0500
Date: Thu, 11 Dec 2003 11:21:08 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Ian Kumlien <pomac@vapor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Message-ID: <20031211182108.GA353@tesore.local>
References: <200312072312.01013.ross@datscreative.com.au> <200312111655.25456.ross@datscreative.com.au> <1071143274.2272.4.camel@big.pomac.com> <200312111912.27811.ross@datscreative.com.au> <1071165161.2271.22.camel@big.pomac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071165161.2271.22.camel@big.pomac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 06:52:41PM +0100, Ian Kumlien wrote:
> Heh, yeah, the need for disconnect is somewhat dodgy, i haven't read up
> on th rest.
> 


Hmm, weird.  I went to go look at the Shuttle motherboard maker's site - maybe so that I can bug them for a bios disconnect option - but I checked for a bios update first.  And sure enough like they read my mind, just posted online today, an update.  Here are the details of fixes:

" Checksum:   8B00H                         Date Code: 12/05/03
1.Support 0.18 micron AMD Duron (Palomino) CPU.
2.Add C1 disconnect item."

It's almost as they're reading this list.  This disconnect problem was discovered on the 5th (well the 5th in my timezone).  Perhaps they're aware of this issue...  I'm gonna talk to them.

Jesse

