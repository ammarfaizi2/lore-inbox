Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWDJFtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWDJFtX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 01:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWDJFtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 01:49:23 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:6359
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751007AbWDJFtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 01:49:22 -0400
Date: Sun, 09 Apr 2006 22:49:13 -0700 (PDT)
Message-Id: <20060409.224913.11924710.davem@davemloft.net>
To: vda@ilport.com.ua
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deinline few large functions in inet6 code
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200604100833.37016.vda@ilport.com.ua>
References: <200604100833.37016.vda@ilport.com.ua>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Vlasenko <vda@ilport.com.ua>
Date: Mon, 10 Apr 2006 08:33:36 +0300

> Deinline a few functions which produce 200+ bytes of code.
> 
> Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>

"Applied."  Happy now? :-)
