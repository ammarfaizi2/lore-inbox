Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbTENXaN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 19:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTENXaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 19:30:13 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:19376 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263163AbTENXaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 19:30:12 -0400
Date: Wed, 14 May 2003 16:38:26 -0700
From: Andrew Morton <akpm@digeo.com>
To: jt@hpl.hp.com
Cc: jt@bougret.hpl.hp.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       hermes@gibson.dropbear.id.au, breed@almaden.ibm.com, achirica@ttd.net,
       jkmaline@cc.hut.fi
Subject: Re: airo and firmware upload (was Re: 2.6 must-fix list, v3)
Message-Id: <20030514163826.6459cd93.akpm@digeo.com>
In-Reply-To: <20030514233235.GA11581@bougret.hpl.hp.com>
References: <20030514211222.GA10453@bougret.hpl.hp.com>
	<3EC2BDEC.6020401@pobox.com>
	<20030514233235.GA11581@bougret.hpl.hp.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 23:42:56.0680 (UTC) FILETIME=[8B938280:01C31A72]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:
>
> firmwares blobs 

well for the purposes of tracking 2.6 activities I'll separate this issue
of firmware access policy out from drivers/net/wireless/. 

yeah, it would be nice if the core kernel provided a "give me my firmware"
API or something.

