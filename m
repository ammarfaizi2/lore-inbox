Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWF3Cks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWF3Cks (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 22:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWF3Ckr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 22:40:47 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:61483 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1750808AbWF3Ckq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 22:40:46 -0400
X-IronPort-AV: i="4.06,193,1149490800"; 
   d="scan'208"; a="326583669:sNHT30866844"
To: Greg KH <gregkh@suse.de>
Cc: Andy Gay <andy@andynet.net>, Jeremy Fitzhardinge <jeremy@goop.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: USB driver for Sierra Wireless EM5625/MC5720 1xEVDO modules
X-Message-Flag: Warning: May contain useful information
References: <1151537247.3285.278.camel@tahini.andynet.net>
	<20060630021332.GB30911@suse.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 29 Jun 2006 19:40:44 -0700
In-Reply-To: <20060630021332.GB30911@suse.de> (Greg KH's message of "Thu, 29 Jun 2006 19:13:32 -0700")
Message-ID: <adabqsbfjrn.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 Jun 2006 02:40:45.0168 (UTC) FILETIME=[963C1700:01C69BEE]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > or:
 >   - send a patch against 2.6.17 that is my changes + your fixes to
 >     actually make it work.
 > 
 > My patch was just a "throw it out there and see what works or not", as I
 > don't even have the device to test it with.

I would love to see such a patch.  I have a Kyocera KPC650 and I would
love to get better performance with it under Linux...

 - R.
