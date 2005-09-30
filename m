Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVI3Ctn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVI3Ctn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVI3Ctn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:49:43 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:229
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932194AbVI3Ctm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:49:42 -0400
Date: Thu, 29 Sep 2005 19:49:30 -0700 (PDT)
Message-Id: <20050929.194930.61559553.davem@davemloft.net>
To: viro@ftp.linux.org.uk
Cc: torvalds@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cassini annotations and fixes
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050930022145.GZ7992@ftp.linux.org.uk>
References: <20050930022145.GZ7992@ftp.linux.org.uk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@ftp.linux.org.uk>
Date: Fri, 30 Sep 2005 03:21:45 +0100

> 	- __user annotations
> 	- NULL noise removal
> 	- C99 initializers
> 	- s/u32/pm_message_t/ in ->suspend()
> 	- removal of bogus casts in iounmap() arguments
> 	- if_mii() instead of open-coded variant
> Remains to be done: ethtool conversion.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Applied, thanks Al.
