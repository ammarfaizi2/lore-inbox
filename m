Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266389AbUFUSju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266389AbUFUSju (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 14:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266398AbUFUSju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 14:39:50 -0400
Received: from [80.72.36.106] ([80.72.36.106]:6535 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S266389AbUFUSjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 14:39:48 -0400
Date: Mon, 21 Jun 2004 20:39:44 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: walt <wa1ter@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.7-bk] NFS-related kernel panic
In-Reply-To: <40D98C72.3040807@myrealbox.com>
Message-ID: <Pine.LNX.4.58.0406212037540.28702@alpha.polcom.net>
References: <40D98C72.3040807@myrealbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004, walt wrote:

> Starting just today with the latest bk changesets I get a kernel
> panic when starting the rpc.statd daemon (NFS):
> 
> Kernel panic:  Aiee, killing interrupt handler
> In interrupt handler - not syncing
> 
> Anyone else seeing problems with NFS?

This is probably not NFS problem since I have no NFS and I get the same. 
Look at my report. I sent it minute ago to this list.


Thanks,

Grzegorz Kulewski

