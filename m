Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbULGArN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbULGArN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 19:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbULGArN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 19:47:13 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:6794 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261722AbULGArK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 19:47:10 -0500
Date: Tue, 7 Dec 2004 01:44:00 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Johan <johan@ccs.neu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: status of via velocity in 2.6.9
Message-ID: <20041207004400.GC12838@electric-eye.fr.zoreil.com>
References: <41B4F447.2060808@ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B4F447.2060808@ccs.neu.edu>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan <johan@ccs.neu.edu> :
> How 'working' are the via velocity drivers in 2.6.9 ?

Apart the fact that the driver does not play nice with the in-kernel
vlan API, I'd say that this is the first PR since the last fixes.

[network stops from time to time]
> Is this known behavior ?

Afaik, not on 2.6.9.

Can you describe the bug and the traffic ?
Any NETDEV watchdog messages or such ?

--
Ueimor
