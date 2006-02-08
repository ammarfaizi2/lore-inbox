Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWBHWLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWBHWLP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 17:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWBHWLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 17:11:15 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59624
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751148AbWBHWLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 17:11:15 -0500
Date: Wed, 08 Feb 2006 14:11:07 -0800 (PST)
Message-Id: <20060208.141107.129210892.davem@davemloft.net>
To: viro@ftp.linux.org.uk
Cc: linux-kernel@vger.kernel.org, adaplas@pol.net
Subject: Re: [PATCH 2/8] atyfb sparc ifdefs
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <E1F6vVX-0008Be-Jk@ZenIV.linux.org.uk>
References: <E1F6vVX-0008Be-Jk@ZenIV.linux.org.uk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 20:01:43 +0000

> Date: 1133417630 -0500
> 
> ... should be sparc64 ones.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Probably CONFIG_SPARC64 is more appropriate.
But I agree either way.
