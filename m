Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263302AbVGALdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbVGALdy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 07:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbVGALdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 07:33:53 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:16391 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S263302AbVGALdB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 07:33:01 -0400
Date: Fri, 1 Jul 2005 13:32:56 +0200
From: Jean Delvare <khali@linux-fr.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [02/07] [SCSI] qla2xxx: Pull-down scsi-host-addition to follow
 board initialization.
Message-Id: <20050701133256.1f08b065.khali@linux-fr.org>
In-Reply-To: <1120062974.4824.18.camel@mulgrave>
References: <20050627224651.GI9046@shell0.pdx.osdl.net>
	<20050627225349.GK9046@shell0.pdx.osdl.net>
	<20050628235148.4512d046.khali@linux-fr.org>
	<20050628152037.690c3840.akpm@osdl.org>
	<20050629100835.60dc42f8.khali@linux-fr.org>
	<1120062974.4824.18.camel@mulgrave>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> > this patch breaks 4 (it is bigger than 100 lines, (...)
>
> Not according to my diffstat, it doesn't:
> 
> qla_os.c |   55
> ++++++++++++++++++++++++++++---------------------------
>  1 files changed, 28 insertions(+), 27 deletions(-)

The original rule was including the context, diffstat doesn't. This
patch was 136 lines long including the context.

Anyway, it doesn't seem to matter anymore.

-- 
Jean Delvare
