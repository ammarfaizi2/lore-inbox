Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269756AbUJMR1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269756AbUJMR1Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 13:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269759AbUJMR1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 13:27:16 -0400
Received: from mail.adebahr.de ([62.146.75.130]:58798 "EHLO mail.adebahr.de")
	by vger.kernel.org with ESMTP id S269756AbUJMR1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 13:27:15 -0400
Date: Wed, 13 Oct 2004 19:27:13 +0200 (CEST)
From: Peter Adebahr <adsys@adebahr.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1
In-Reply-To: <87r7o23gdu.fsf@barad-dur.crans.org>
Message-ID: <Pine.LNX.4.61.0410131924110.16426@siraly.adebahr.de>
References: <20041011032502.299dc88d.akpm@osdl.org> <1097672832.5500.60.camel@homer.blizzard.org>
 <87r7o23gdu.fsf@barad-dur.crans.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004, Mathieu Segaud wrote:

>
> here's a fix
> cd /usr/src/linux-2.6.9-rc4-mm1
> wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/optimize-profile-path-slightly.patch
> patch -R -p1 < optimize-profile-path-slightly.patch
>
> this should fix the sources and so...
>

yes, helps here, too - on a redhat based (but otherwise self configured)
system, w/ self compiled firefox.

pse include resp. remove in next -mm.

thanks a lot!

best regards,
Peter
