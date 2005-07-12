Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVGLJT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVGLJT1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVGLJTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:19:25 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:10454 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S261288AbVGLJSu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:18:50 -0400
Subject: Re: [PATCH 0/29v2] InfiniBand core update
From: Hal Rosenstock <halr@voltaire.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, rolandd@cisco.com
In-Reply-To: <20050711.201225.34760317.davem@davemloft.net>
References: <1121110249.4389.4984.camel@hal.voltaire.com>
	 <20050711170548.31605e23.akpm@osdl.org>
	 <1121136330.4389.5093.camel@hal.voltaire.com>
	 <20050711.201225.34760317.davem@davemloft.net>
Content-Type: text/plain
Organization: 
Message-Id: <1121159462.4389.5108.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Jul 2005 05:11:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 23:12, David S. Miller wrote:
> Please acknowledge that you understand how inappropriate
> and problem causing your huge patch bomb was today to this
> mailing list.
> 
> It is nearly 8 hours later, and vger.kernel.org is still
> trying mightily to spit out all of your patches to the
> 5000+ people subscribed to linux-kernel.
> 
> There is about ~6 hour posting latency as a result of all
> of this.

I understand the problem it caused. The MAD layer of InfiniBand was 
quite a bit behind and we wanted to catch up. I tried to make them in
smaller manageable pieces and that was why there were so many patches in
the series. In the future, I will endeavor to make the changes smaller.
Sorry for the problems this caused.

-- Hal

