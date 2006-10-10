Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030549AbWJJVvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030549AbWJJVvF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030537AbWJJVu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:50:56 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:33191
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030532AbWJJVuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:50:17 -0400
Date: Tue, 10 Oct 2006 14:50:17 -0700 (PDT)
Message-Id: <20061010.145017.40575796.davem@davemloft.net>
To: joro-lkml@zlug.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/02 V3] net/ipv6: seperate sit driver to extra module
 (addrconf.c changes)
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061010154355.GD27455@zlug.org>
References: <20061010153745.GA27455@zlug.org>
	<20061010154355.GD27455@zlug.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <joro-lkml@zlug.org>
Date: Tue, 10 Oct 2006 17:43:55 +0200

> This patch contains the changes to net/ipv6/addrconf.c to remove sit
> specific code if the sit driver is not selected.
> 
> Signed-off-by: Joerg Roedel <joro-lkml@zlug.org>
> Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

Applied, thanks a lot.
