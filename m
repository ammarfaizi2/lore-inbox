Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVCGXi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVCGXi1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVCGXhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:37:47 -0500
Received: from nn1.excitenetwork.com ([207.159.120.55]:5434 "EHLO excite.com")
	by vger.kernel.org with ESMTP id S261953AbVCGXS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:18:59 -0500
To: linux-kernel@vger.kernel.org
Subject: Random number generator in Linux kernel
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: ID = 879b4ea53dbad4bbc16ad4568876f5e4
Reply-To: vintya@excite.com
From: "Vineet Joglekar" <vintya@excite.com>
MIME-Version: 1.0
X-Mailer: PHP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-c-programming@vger.kernel.org
Message-Id: <20050307231853.9F661B6E7@xprdmailfe20.nwk.excite.com>
Date: Mon,  7 Mar 2005 18:18:53 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Can someone please tell me where can I find and which random/pseudo-random number generator can I use inside the linux kernel? (2.4.28)

I found out 1 function get_random_bytes() in linux/drivers/char/random.c but thats not what I want.

I want a function where I will be supplying a seed to that function as an input, and will get a random number back. If same seed is used, same number should be generated again.

Can anybody please help me with that?

Thanks and regards,

Vineet.

_______________________________________________
Join Excite! - http://www.excite.com
The most personalized portal on the Web!
