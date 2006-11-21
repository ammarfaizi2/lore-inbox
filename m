Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030629AbWKUA47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030629AbWKUA47 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 19:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030627AbWKUA47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 19:56:59 -0500
Received: from localhost.localdomain ([127.0.0.1]:50091 "EHLO localhost")
	by vger.kernel.org with ESMTP id S1030618AbWKUA46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 19:56:58 -0500
Date: Mon, 20 Nov 2006 19:56:58 -0500 (EST)
Message-Id: <20061120.195658.70202271.davem@davemloft.net>
To: bunk@stusta.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/ipv6/sit.c: make 2 functions static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061117170232.GH31879@stusta.de>
References: <20061117170232.GH31879@stusta.de>
X-Mailer: Mew version 5.1 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Fri, 17 Nov 2006 18:02:32 +0100

> This patch makes two needlessly global functions static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied to net-2.6.20, thanks Adrian.
