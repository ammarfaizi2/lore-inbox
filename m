Return-Path: <linux-kernel-owner+w=401wt.eu-S1161077AbXAEMnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbXAEMnZ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 07:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbXAEMnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 07:43:25 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:58641 "EHLO
	extu-mxob-2.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161077AbXAEMnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 07:43:24 -0500
X-AuditID: d80ac287-a10c4bb000002548-e7-459e48cdafe7 
Date: Fri, 5 Jan 2007 12:43:41 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Kay Sievers <kay.sievers@vrfy.org>
cc: Greg KH <gregkh@suse.de>, Miles Lane <miles.lane@gmail.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       yi.zhu@intel.com
Subject: Re: 2.6.20-rc2-mm1 -- INFO: possible recursive locking detected
In-Reply-To: <1167996872.21293.2.camel@pim.off.vrfy.org>
Message-ID: <Pine.LNX.4.64.0701051242270.10883@blonde.wat.veritas.com>
References: <a44ae5cd0612300247n529f48a6t81edb503bc646f73@mail.gmail.com> 
 <20070104214747.GD28445@suse.de>  <Pine.LNX.4.64.0701042339080.4441@blonde.wat.veritas.com>
  <20070104235758.GA32132@suse.de> <1167996872.21293.2.camel@pim.off.vrfy.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 05 Jan 2007 12:43:23.0353 (UTC) FILETIME=[16440490:01C730C7]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007, Kay Sievers wrote:
> > 
> > But anyway, Kay, I thought that 10.2 would work with
> > CONFIG_SYSFS_DEPRECATED=y?
> 
> Yes, HAL, udev, NetworkManager, ... from 10.2 works fine here, without
> that option set.

I'm using ifplugd rather than NetworkManager: would that affect it?

Hugh
