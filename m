Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268594AbUIXIby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268594AbUIXIby (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 04:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268593AbUIXIbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 04:31:53 -0400
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:49865 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S268594AbUIXIbo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 04:31:44 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: lost memory on a 4GB amd64
Date: Fri, 24 Sep 2004 09:31:42 +0100
User-Agent: KMail/1.7
Cc: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au> <200409240915.34471.andrew@walrond.org> <Pine.LNX.4.58.0409241819370.15313@fb07-calculator.math.uni-giessen.de>
In-Reply-To: <Pine.LNX.4.58.0409241819370.15313@fb07-calculator.math.uni-giessen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409240931.42356.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 Sep 2004 09:23, Sergei Haller wrote:
> It's the same for me if I use the non-SMP version of the kernel.
> but the SMP one seems to be panicking for some reason.
>

Just a thought; How are the memory modules arranged on the board?
I have 2 x 1Gb modules in each cpu-specific bank, rather than all four in 
cpu1's bank. How are yours arranged?


