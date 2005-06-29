Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVF2PXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVF2PXv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 11:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVF2PXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 11:23:50 -0400
Received: from mail.dvmed.net ([216.237.124.58]:35037 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261357AbVF2PXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 11:23:49 -0400
Message-ID: <42C2BCF3.8020003@pobox.com>
Date: Wed, 29 Jun 2005 11:23:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Chua <jeff96@silk.corp.fedex.com>
CC: ipw2100-devel@lists.sourceforge.net, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ipw2200 can't compile under linux 2.6.13-rc1
References: <Pine.LNX.4.63.0506291806580.14237@boston.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.63.0506291806580.14237@boston.corp.fedex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua wrote:
> 
> ipw2200-1.0.4 can't be compiled under linux 2.6.13-rc1.
> 
> ipw2200-1.0.4 compiled fine with linux 2.6.12.

It compiles just fine.

You're not using the 'ieee80211' repository where all wireless 
developers work out of.  That's the big problem.

	Jeff



