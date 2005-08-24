Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVHXRTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVHXRTv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVHXRTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:19:51 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:41646 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751233AbVHXRTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:19:50 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Another libata TODO item
X-Message-Flag: Warning: May contain useful information
References: <430C10E7.9060502@pobox.com>
	<20050824074116.GF24513@infradead.org> <430C271E.7060006@pobox.com>
	<52d5o31fce.fsf@cisco.com> <430CA617.6090106@pobox.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 24 Aug 2005 10:19:41 -0700
In-Reply-To: <430CA617.6090106@pobox.com> (Jeff Garzik's message of "Wed, 24
 Aug 2005 12:53:43 -0400")
Message-ID: <52ll2rz1zm.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Aug 2005 17:19:43.0316 (UTC) FILETIME=[04905940:01C5A8D0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jeff> Look at net drivers.  Theres no real infrastructure beyond
    Jeff> bit tests and printks.  I wouldn't call that a subsystem,
    Jeff> so, I wouldn't call this one such either.

Well, scsi_logging.h isn't much of a subsystem either.

 - R.
