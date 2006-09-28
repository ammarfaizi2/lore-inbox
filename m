Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751929AbWI1SPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbWI1SPH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 14:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbWI1SPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 14:15:07 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:5389 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751929AbWI1SPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 14:15:04 -0400
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 4 of 28] IB/ipath - support revision 2 InfiniPath PCIE devices
X-Message-Flag: Warning: May contain useful information
References: <a69f8b7a8a04a8742e0f.1159459200@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 28 Sep 2006 11:15:03 -0700
In-Reply-To: <a69f8b7a8a04a8742e0f.1159459200@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Thu, 28 Sep 2006 09:00:00 -0700")
Message-ID: <adaodsz5048.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 28 Sep 2006 18:15:03.0735 (UTC) FILETIME=[04EC1470:01C6E32A]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +	/* 

 > +		/* Use GPIO interrupts for new counters */    

trailing whitespace...
