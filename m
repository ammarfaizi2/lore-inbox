Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVFMVVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVFMVVa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVFMVPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:15:25 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:29407
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261331AbVFMU6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:58:14 -0400
Date: Mon, 13 Jun 2005 13:57:48 -0700 (PDT)
Message-Id: <20050613.135748.85419529.davem@davemloft.net>
To: willy@w.ods.org
Cc: herbert@gondor.apana.org.au, xschmi00@stud.feec.vutbr.cz,
       alastair@unixtrix.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050613081025.GA13407@alpha.home.local>
References: <20050613061748.GA13144@alpha.home.local>
	<20050613074521.GA21661@gondor.apana.org.au>
	<20050613081025.GA13407@alpha.home.local>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <willy@w.ods.org>
Date: Mon, 13 Jun 2005 10:10:26 +0200

> On Mon, Jun 13, 2005 at 05:45:21PM +1000, Herbert Xu wrote:
> > Anyway, let's leave it to Dave to make the decision.
> 
> At least, he has enough elements in his mailbox now :-)

I'm still thinking about this one, sit tight :)
