Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267566AbUHTF2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267566AbUHTF2F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 01:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267568AbUHTF2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 01:28:05 -0400
Received: from p54808FDB.dip.t-dialin.net ([84.128.143.219]:12 "EHLO
	pro01.local.promotion-ie.de") by vger.kernel.org with ESMTP
	id S267566AbUHTF2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 01:28:03 -0400
From: alex@local.promotion-ie.de
Subject: Re: acpi shutdown problem on SMP (tyan tiger mp, athlon)
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Willy Tarreau <willy@w.ods.org>
In-Reply-To: <1092376617.8529.13.camel@pro30.local.promotion-ie.de>
References: <1092376617.8529.13.camel@pro30.local.promotion-ie.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092979681.31552.2.camel@pro11.local.promotion-ie.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 07:28:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the acpi patches in 2.6.8.1-mm2 fix the acpi shutdown problem on this
board.

On Fri, 2004-08-13 at 07:56, Alexander Rauth wrote:
> this problem first appeared in vanilla-2.6.2 and is still present in
> vanilla-2.6.8-rc4 (vanilla-2.6.1 worked fine)
> 
> on shutdown the disks spin down, the VGA switches to powersave, but the
> cpu-fans and the power-supply won't power down.

