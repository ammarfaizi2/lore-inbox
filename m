Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUH3VyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUH3VyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 17:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUH3VyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 17:54:11 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:46289 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263540AbUH3VyJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 17:54:09 -0400
Date: Mon, 30 Aug 2004 23:52:27 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RFT] 8139cp TSO support
Message-ID: <20040830215227.GA23857@electric-eye.fr.zoreil.com>
References: <20040829212205.GA2864@havoc.gtf.org> <20040829222831.GA9496@electric-eye.fr.zoreil.com> <41326079.9090402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41326079.9090402@pobox.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> :
[...]
> You definitely want to set .len on the no-frags path...

Oops.. Patch follows.

I won't have a neat tso enabled r8169 driver today. Something goes wrong.

--
Ueimor
