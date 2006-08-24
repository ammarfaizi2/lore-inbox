Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWHXDj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWHXDj5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 23:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWHXDj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 23:39:57 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:5346 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030258AbWHXDj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 23:39:56 -0400
Message-ID: <44ED1F88.20304@garzik.org>
Date: Wed, 23 Aug 2006 23:39:52 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][REPOST] WAN: fix C101 card carrier handling
References: <m3k651udsq.fsf@defiant.localdomain>
In-Reply-To: <m3k651udsq.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Hi,
> 
> One of my recent changes broke C101 carrier handling, this patch
> fixes it. Also fixes an old TX underrun checking bug.
> 
> 2.6.18 material. Please apply.

it's already in netdev-2.6.git#upstream-fixes, destined for 2.6.18.

	Jeff



