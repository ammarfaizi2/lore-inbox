Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTL2MIa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 07:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTL2MI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 07:08:29 -0500
Received: from 213-145-178-72.dd.nextgentel.com ([213.145.178.72]:31464 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263357AbTL2MI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 07:08:28 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm2
References: <1822L-89t-7@gated-at.bofh.it>
From: s864@ii.uib.no (Ronny V. Vindenes)
Date: 29 Dec 2003 13:08:17 +0100
Message-ID: <m3brpr4yj2.fsf@terminal124.gozu.lan>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0/2.6.0-mm2/
> 

> 
> Changes since 2.6.0-mm1:
> 
> 
> +2.6.0-netdrvr-exp3.patch
> +2.6.0-netdrvr-exp3-fix.patch
> +Space_c-warning-fix.patch
> +via-rhine-netpoll-support.patch
> 
>  Experimental net driver tree, plus fixups.
> 

r8169 driver is broken to the point of being completely unusable for
me. Upon loading the r8169 module the nic puts on a pretty lightshow
from which it only recovers after a powercycle. The nic is an onboard
8110S on a MSI K8T Neo. The old r8169 driver works, but is far from
perfect ofcourse.

-- 
Ronny V. Vindenes <s864@ii.uib.no>
