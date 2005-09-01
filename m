Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbVIAW1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbVIAW1z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbVIAW1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:27:55 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8627
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030470AbVIAW1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:27:54 -0400
Date: Thu, 01 Sep 2005 15:27:56 -0700 (PDT)
Message-Id: <20050901.152756.129850004.davem@davemloft.net>
To: pcaulfie@redhat.com
Cc: linux-kernel@vger.kernel.org, steve@chygwyn.com
Subject: Re: [PATCH] DECnet Tidy
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050830084736.GA32184@tykepenguin.com>
References: <20050830084736.GA32184@tykepenguin.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Caulfield <pcaulfie@redhat.com>
Date: Tue, 30 Aug 2005 09:47:36 +0100

> Patch from Steve which I've vetted and tested:
> 
> "This patch is really intended has a move towards fixing the sendmsg/recvmsg     
>  functions in various ways so that we will finally have working nagle. Also      
>  reduces code duplication. "
> 
> Signed-off-by: Patrick Caulfield <patrick@tykepenguin.com>

Applied, thanks.
