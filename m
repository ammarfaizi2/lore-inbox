Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbUKWBZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUKWBZE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 20:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbUKVWva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:51:30 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:26878 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261172AbUKVWus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:50:48 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <20041122713.Nh0zRPbm8qA0VBxj@topspin.com>
	<20041122221304.GA15634@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 22 Nov 2004 14:50:41 -0800
In-Reply-To: <20041122221304.GA15634@kroah.com> (Greg KH's message of "Mon,
 22 Nov 2004 14:13:04 -0800")
Message-ID: <52wtwdbiri.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][RFC/v1][0/12] Initial submission of InfiniBand patches
 for review
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 22 Nov 2004 22:50:47.0163 (UTC) FILETIME=[B4BD9CB0:01C4D0E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> Who would be including these files, only drivers in
    Greg> drivers/infiniband?  Or from files in other parts of the
    Greg> kernel?

In the current patchset all the code is under drivers/infiniband.

    Greg> If from other parts of the kernel, use include/linux/infiniband.

That's one vote for include/linux/infiniband and two votes for
include/infiniband so far...

 - R.
