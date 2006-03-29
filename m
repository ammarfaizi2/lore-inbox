Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWC2Wfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWC2Wfc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWC2Wfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:35:31 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:49129 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751074AbWC2Wfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:35:30 -0500
Message-ID: <442B0BA2.9020200@garzik.org>
Date: Wed, 29 Mar 2006 17:35:14 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: tsbogend@alpha.franken.de, donf@us.ibm.com, jklewis@us.bm.com,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] Janitor: drivers/net/pcnet32: fix incorrect comments
References: <20060328223623.GD2172@austin.ibm.com>
In-Reply-To: <20060328223623.GD2172@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.5 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> Please sign-off/ack/apply and/or forward upstream.
> 
> [PATCH] Janitor: drivers/net/pcnet32: fix incorrect comments
> 
> The comments concerning how the pcnet32 ethernet device driver selects 
> the MAC addr to use are incorrect. A recent patch (in the last 3 months)
> changed how the code worked, but did not change the comments.
> 
> Side comment: the new behaviour is good; I've got a pcnet32 card which
> powers up with garbage in the CSR's, and a good MAC addr in the PROM.
> 
> Signed-off-by: Linas Vepstas <linas@linas.org>

applied


