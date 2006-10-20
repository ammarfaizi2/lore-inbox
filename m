Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751682AbWJTF6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbWJTF6h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 01:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbWJTF6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 01:58:36 -0400
Received: from mailer.campus.mipt.ru ([194.85.82.4]:50626 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S1751681AbWJTF6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 01:58:36 -0400
Date: Fri, 20 Oct 2006 09:59:40 +0400
Message-Id: <200610200559.k9K5xelj031775@vass.7ka.mipt.ru>
From: Vasily Tarasov <vtaras@openvz.org>
To: Randy Dunlap <rdunlap@xenotime.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
CC: Jan Kara <jack@suse.cz>
CC: Dmitry Mishin <dim@openvz.org>
CC: Vasily Averin <vvs@sw.ru>
CC: Kirill Korotaev <dev@openvz.org>
CC: OpenVZ Developers List <devel@openvz.org>
Rerences: <200610191232.k9JCW7CF015486@vass.7ka.mipt.ru> <20061019082218.86aa5405.rdunlap@xenotime.net>
Subject: Re: [PATCH] diskquota: 32bit quota tools on 64bit architectures
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Fri, 20 Oct 2006 09:58:08 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:

<snip>
> Please align the switch and case/default source lines.
> We prefer not to "double-indent" each case block inside a switch.
>
> I suppose I should try to add this to CodingStyle since it's
> not there.
>   
> ---
> ~Randy
<snip>

Thank you, I'll  do it!
