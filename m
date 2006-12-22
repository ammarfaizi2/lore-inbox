Return-Path: <linux-kernel-owner+w=401wt.eu-S1754836AbWLVN3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836AbWLVN3R (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 08:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754837AbWLVN3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 08:29:17 -0500
Received: from smtp151.iad.emailsrvr.com ([207.97.245.151]:35740 "EHLO
	smtp151.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836AbWLVN3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 08:29:17 -0500
Message-ID: <458BDDDE.8050201@gentoo.org>
Date: Fri, 22 Dec 2006 08:30:06 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 2.0b1 (X11/20061221)
MIME-Version: 1.0
To: Marc Haber <mh+linux-kernel@zugschlus.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 file content corruption on ext3
References: <20061207155740.GC1434@torres.l21.ma.zugschlus.de>
In-Reply-To: <20061207155740.GC1434@torres.l21.ma.zugschlus.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Haber wrote:
> After updating to 2.6.19, Debian's apt control file
> /var/cache/apt/pkgcache.bin corrupts pretty frequently - like in under
> six hours. In that situation, "aptitude update" segfaults. When I
> delete the file and have apt recreate it, things are fine again for a
> few hours before the file is broken again and the segfault start over.
> In all cases, umounting the file system and doing an fsck does not
> show issues with the file system.

Are you using wireless networking of any kind? If so which driver and 
security key system? Might be useful if you could post 'dmesg' output so 
that people can see the other hardware that you have.

Daniel

