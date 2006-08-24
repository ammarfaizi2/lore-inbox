Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752325AbWHXN0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbWHXN0X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbWHXN0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:26:22 -0400
Received: from khc.piap.pl ([195.187.100.11]:11973 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751727AbWHXN0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:26:22 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][REPOST] WAN: fix C101 card carrier handling
References: <m3k651udsq.fsf@defiant.localdomain> <44ED1F88.20304@garzik.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 24 Aug 2006 15:26:19 +0200
In-Reply-To: <44ED1F88.20304@garzik.org> (Jeff Garzik's message of "Wed, 23 Aug 2006 23:39:52 -0400")
Message-ID: <m3fyfmp8n8.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> writes:

>> One of my recent changes broke C101 carrier handling, this patch
>> fixes it. Also fixes an old TX underrun checking bug.
>> 2.6.18 material. Please apply.
>
> it's already in netdev-2.6.git#upstream-fixes, destined for 2.6.18.

Great, I somehow missed it. Thank you.
-- 
Krzysztof Halasa
