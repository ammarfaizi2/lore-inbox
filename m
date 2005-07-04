Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVGEVYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVGEVYD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVGEVYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:24:03 -0400
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:15753 "EHLO
	gw02.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S261992AbVGEVL1 (ORCPT <rfc822;<linux-kernel@vger.kernel.org>>);
	Tue, 5 Jul 2005 17:11:27 -0400
From: Jan Knutar <jk-lkml@sci.fi>
To: matthieu castet <castet.matthieu@free.fr>
Subject: Re: ide-cd and bad sectors
Date: Tue, 5 Jul 2005 01:42:34 +0300
User-Agent: KMail/1.6.2
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <42C6A12A.8030009@free.fr>
In-Reply-To: <42C6A12A.8030009@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200507050142.34324.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 July 2005 17:14, matthieu castet wrote:

> IIRC on 2.4 kernel there wasn't such problem, I even managed to recover 
> some damaged disk...

Oh on some 2.4 the kernel would retry each sector so many times that recovering
undamaged sectors from a CD would have taken longer than the MTBF for a CDROM
drive :)
