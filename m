Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWHaWV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWHaWV5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 18:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWHaWV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 18:21:57 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7400
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932459AbWHaWV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 18:21:56 -0400
Date: Thu, 31 Aug 2006 15:22:02 -0700 (PDT)
Message-Id: <20060831.152202.112833372.davem@davemloft.net>
To: mita@miraclelinux.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] rate limiting for socket allocation failure messages
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060831095921.GA13845@miraclelinux.com>
References: <20060831095921.GA13845@miraclelinux.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <mita@miraclelinux.com>
Date: Thu, 31 Aug 2006 18:59:21 +0900

> (Resending due to local mail server trouble)
> 
> This patch limits the warning messages when socket allocation
> failures happen. It happens under memory pressure.
> 
> Cc: David Miller <davem@davemloft.net>
> Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

Patch applied, thanks a lot.
