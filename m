Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265514AbTGKTRc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265503AbTGKTPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 15:15:52 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:17556 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265453AbTGKTPF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 15:15:05 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 11 Jul 2003 12:22:16 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Dave Jones <davej@codemonkey.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
In-Reply-To: <20030711140219.GB16433@suse.de>
Message-ID: <Pine.LNX.4.55.0307111218510.4677@bigblue.dev.mcafeelabs.com>
References: <20030711140219.GB16433@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003, Dave Jones wrote:

> - gcc 3.2.2-5 as shipped by Red Hat generates incorrect code in the
>   kmalloc optimisation introduced in 2.5.71
>   See http://linus.bkbits.net:8080/linux-2.5/cset@1.1410

IIRC this is a sub-optimal code generation more then a panic generator.



- Davide

