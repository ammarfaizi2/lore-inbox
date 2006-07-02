Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932745AbWGBSsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745AbWGBSsr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 14:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932754AbWGBSsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 14:48:46 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:25209 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S932745AbWGBSsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 14:48:45 -0400
To: Andy Gay <andy@andynet.net>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO	transfers
X-Message-Flag: Warning: May contain useful information
References: <1151646482.3285.410.camel@tahini.andynet.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 02 Jul 2006 11:48:40 -0700
In-Reply-To: <1151646482.3285.410.camel@tahini.andynet.net> (Andy Gay's message of "Fri, 30 Jun 2006 01:48:02 -0400")
Message-ID: <adad5cnderb.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Jul 2006 18:48:43.0563 (UTC) FILETIME=[247B5FB0:01C69E08]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this works well on my kyocera kpc650 -- throughput is up to about 1
mbit/sec vs. ~250 kbit/sec with the stock airprime driver.
