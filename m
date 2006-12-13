Return-Path: <linux-kernel-owner+w=401wt.eu-S964946AbWLMGIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWLMGIQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 01:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWLMGIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 01:08:16 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:34072 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964946AbWLMGIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 01:08:15 -0500
X-Greylist: delayed 1659 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 01:08:15 EST
Message-ID: <457F9243.9090701@garzik.org>
Date: Wed, 13 Dec 2006 00:40:19 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: NeilBrown <neilb@suse.de>
CC: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000 of 14] knfsd: Assorted nfsd patches for 2.6.20 - prepare
 for IPv6 and more
References: <20061213105528.21128.patches@notabene>
In-Reply-To: <20061213105528.21128.patches@notabene>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown wrote:
> Following are 14 patches for knfsd that are suitable for inclusion in 2.6.20.
> First 13 are from Chuck Lever and make preparations for IPv6 support (I think we've
> get them right this time).
> 
> Last is from Peter Staubach and fixes and issue with exclusive create
> interacting badly with some ACLs.


Any word on this 2.6.19 oops?

http://lkml.org/lkml/2006/12/8/110

	Jeff


