Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946782AbWKJXXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946782AbWKJXXf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 18:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946761AbWKJXXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 18:23:35 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62113 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946782AbWKJXXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 18:23:34 -0500
Date: Fri, 10 Nov 2006 23:28:19 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: drivers/uio
Message-ID: <20061110232819.378b250a@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We had a discussion a while back about drivers/uio and the fact the stuff
was buggy, contained security holes and not really fit/ready for -mm.
Since that point nobody has fixed it (in part because they are doing
vastly cooler stuff elsewhere in the kernel) so I think its time
drivers/uio in -mm talk a walk to the bitbucket until someone makes it
secure and resurrects it if needed.

So given the elapsed time

NACK: drivers/uio

Alan
