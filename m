Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbTJNTau (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 15:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTJNTau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 15:30:50 -0400
Received: from havoc.gtf.org ([63.247.75.124]:55265 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262766AbTJNTat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 15:30:49 -0400
Date: Tue, 14 Oct 2003 15:30:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: New queue:  net-drivers-exp
Message-ID: <20031014193048.GA22739@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Over time while using BK, I have developed "queues", or buckets, into
which patches are sorted.  One of the key ones are the
net-drivers-2.[45] queues, which are staging areas for sending
net-driver-related patches to Marcelo and Linus.

With the "bug fixes only" freeze in 2.6, I took the opportunity to send
some of the non-bugfix patches to a new pair of queues,
"net-drivers-2.[45]-exp", with "-exp" meaning experimental.

The contents of net-drivers-2.[45]-exp will be patches pending for
Marcelo or Linus, but ones that need to "stew" for a little while.
Brand new features and drivers will sit here for a week or two, usually,
to allow for greater public review and testing.

See upcoming 2.4 and 2.6 postings for BitKeeper and patch URLs.

	Jeff




