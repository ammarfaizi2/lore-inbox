Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVKFCpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVKFCpo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 21:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVKFCpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 21:45:44 -0500
Received: from www.swissdisk.com ([216.144.233.50]:25813 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S932146AbVKFCpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 21:45:44 -0500
Date: Sat, 5 Nov 2005 17:37:52 -0800
From: Ben Collins <bcollins@ubuntu.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Ubuntu kernel tree
Message-ID: <20051106013752.GA13368@swissdisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some people may have noticed the new git tree located at:

rsync.kernel.org:/pub/scm/linux/kernel/git/bcollins/ubuntu-2.6.git

This tree will directly reflect the Ubuntu Linux Kernel that is available
in our distribution (along with build system). First use of this kernel
tree is slated for Dapper Drake (Ubuntu 6.04), and will stay synced with
the just released 2.6.14(.y).

There are several reasons for making this repo available on kernel.org.
Primary reasons include a more open development model, better visibility
with the kernel developer community, and to make the kernel available to
other distro's who may want to base their kernel off of ours.

Primary goals include:

* A kernel geared toward a real world Linux distribution, supporting
  drivers and subsystems that end users need. You will find a lot of
  external drivers in our tree, that for whatever reason, are not included
  in the upstream kernel. We hope that including these drivers will give
  users a one-stop kernel (no downloading and compiling external modules),
  and also provide much needed testing for modules hoping to be included
  into the mainstream kernel.

* Real world configurations. We will provide default kernel configs for a
  variety of architectures and system "flavors".

* Any feature and/or driver included will attempt to be configurable. That
  is, if you don't select to compile it, it will not cause any significant
  changes from the stock kernel we are using at that point.

* Open development model. We want to be as close to the kernel community
  as possible. Integrating ideas, getting feedback, and causing as little
  havoc as possible :)


-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/
