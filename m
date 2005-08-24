Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbVHXRYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVHXRYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVHXRYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:24:36 -0400
Received: from mail.dvmed.net ([216.237.124.58]:11672 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751240AbVHXRYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:24:35 -0400
Message-ID: <430CAD4C.9030804@pobox.com>
Date: Wed, 24 Aug 2005 13:24:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <rolandd@cisco.com>
CC: Christoph Hellwig <hch@infradead.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Another libata TODO item
References: <430C10E7.9060502@pobox.com>	<20050824074116.GF24513@infradead.org> <430C271E.7060006@pobox.com>	<52d5o31fce.fsf@cisco.com> <430CA617.6090106@pobox.com> <52ll2rz1zm.fsf@cisco.com>
In-Reply-To: <52ll2rz1zm.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Jeff> Look at net drivers.  Theres no real infrastructure beyond
>     Jeff> bit tests and printks.  I wouldn't call that a subsystem,
>     Jeff> so, I wouldn't call this one such either.
> 
> Well, scsi_logging.h isn't much of a subsystem either.

You obviously did not grep for CONFIG_SCSI_LOGGING :)

	Jeff


