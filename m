Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVHXQyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVHXQyD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVHXQyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:54:01 -0400
Received: from mail.dvmed.net ([216.237.124.58]:7064 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751163AbVHXQyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:54:00 -0400
Message-ID: <430CA617.6090106@pobox.com>
Date: Wed, 24 Aug 2005 12:53:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <rolandd@cisco.com>
CC: Christoph Hellwig <hch@infradead.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Another libata TODO item
References: <430C10E7.9060502@pobox.com>	<20050824074116.GF24513@infradead.org> <430C271E.7060006@pobox.com> <52d5o31fce.fsf@cisco.com>
In-Reply-To: <52d5o31fce.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Jeff> In any case, I also contine to be skeptical of in-kernel
>     Jeff> logging subsystems.
> 
> Aren't you proposing a libata logging subsystem?

Look at net drivers.  Theres no real infrastructure beyond bit tests and 
printks.  I wouldn't call that a subsystem, so, I wouldn't call this one 
such either.

	Jeff



