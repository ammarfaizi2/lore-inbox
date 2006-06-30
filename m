Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWF3UEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWF3UEq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 16:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWF3UEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 16:04:46 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:3855 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750969AbWF3UEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 16:04:45 -0400
To: Andy Gay <andy@andynet.net>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO	transfers
X-Message-Flag: Warning: May contain useful information
References: <1151646482.3285.410.camel@tahini.andynet.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 30 Jun 2006 13:04:42 -0700
In-Reply-To: <1151646482.3285.410.camel@tahini.andynet.net> (Andy Gay's message of "Fri, 30 Jun 2006 01:48:02 -0400")
Message-ID: <ada7j2yfm05.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 Jun 2006 20:04:43.0750 (UTC) FILETIME=[6DBD3060:01C69C80]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +		/* something happened, so free up the memory for this urb /*

an obvious glitch here at the end of the line...
