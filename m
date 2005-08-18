Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbVHREtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVHREtH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 00:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVHREtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 00:49:07 -0400
Received: from dsl027-180-204.sfo1.dsl.speakeasy.net ([216.27.180.204]:40880
	"EHLO outer-richmond.davemloft.net") by vger.kernel.org with ESMTP
	id S1751344AbVHREtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 00:49:06 -0400
Date: Wed, 17 Aug 2005 21:48:45 -0700 (PDT)
Message-Id: <20050817.214845.120320066.davem@davemloft.net>
To: akpm@osdl.org
Cc: riel@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH/RFT 4/5] CLOCK-Pro page replacement
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050817210532.54ace193.akpm@osdl.org>
References: <20050817173818.098462b5.akpm@osdl.org>
	<20050817.194822.92757361.davem@davemloft.net>
	<20050817210532.54ace193.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Wed, 17 Aug 2005 21:05:32 -0700

> Perhaps by uprevving the compiler version?

Can't be, we definitely support gcc-2.95 and that compiler
definitely has the bug on sparc64.

