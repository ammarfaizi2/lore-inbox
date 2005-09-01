Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030480AbVIAWbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbVIAWbv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030483AbVIAWbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:31:51 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57295
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030480AbVIAWbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:31:50 -0400
Date: Thu, 01 Sep 2005 15:31:42 -0700 (PDT)
Message-Id: <20050901.153142.18055974.davem@davemloft.net>
To: jesper.juhl@gmail.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
       sri@us.ibm.com, bfields@fieldses.org, yoshfuji@linux-ipv6.org,
       breed@users.sourceforge.net, andros@citi.umich.edu, adobriyan@mail.ru
Subject: Re: [PATCH] crypto_free_tfm callers no longer need to check for
 NULL
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200508312220.14929.jesper.juhl@gmail.com>
References: <200508312220.14929.jesper.juhl@gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied, thanks Jesper.

Can you avoid those "/./" things from showing up in the file paths of
the patches you post?  They upset the GIT patch application scripts
and diff verifiers, so I had to edit them out by hand.

Thanks again.
