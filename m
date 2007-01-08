Return-Path: <linux-kernel-owner+w=401wt.eu-S964906AbXAHVy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbXAHVy6 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbXAHVy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:54:58 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44288 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964906AbXAHVy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:54:57 -0500
Date: Mon, 8 Jan 2007 22:05:44 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 file system went read-only in 2.6.18.2 (plus hacks)
Message-ID: <20070108220544.0febd10b@localhost.localdomain>
In-Reply-To: <45A2B9DA.20104@candelatech.com>
References: <45A2B9DA.20104@candelatech.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> pktgen: pktgen_mark_device marking eth0#5 for removal
> pktgen: pktgen_mark_device marking eth0#0 for removal
> .....
> 
> After restarting and a manual fsck, the system appears to
> be back to normal.

Did the fsck find any errors ?
