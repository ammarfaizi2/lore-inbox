Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbWJBVAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbWJBVAt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbWJBVAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:00:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1459 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965109AbWJBVAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:00:47 -0400
Date: Mon, 2 Oct 2006 14:00:41 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] iproute2-2.6.18-061002
Message-ID: <20061002140041.02ef3936@freekitty>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.4; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

his is a much delayed update to the iproute2 command set.
It can be downloaded from:
  http://developer.osdl.org/dev/iproute2/download/iproute2-2.6.18-061002.tar.gz

Repository:
  git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/iproute2.git

For more info on iproute2 see:
  http://linux-net.osdl.org/index.php/Iproute2

The version number includes the kernel version to denote what features are
supported. The same source should build on older systems, but obviously the
newer kernel features won't be available. As much as possible, this package
tries to be source compatible across releases.

Summary of changes:
	- converted to git
	- build fixes for some distributions
	- bug fix for xfrm monitor
	- alignment fixes for cris
	- documentation corrections
	- many small bug fixes
	- new tc monitor mode

Contributors to this release
	Jamal Hadi Salim
	Patrick McHardy
	Andy Gay
	Jesper Dangaard Brouer
	Vince Worthington 
	
Git changelog is a bit of a mess, so if I missed your name sorry.
