Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbUDMS7v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 14:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263680AbUDMS7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 14:59:51 -0400
Received: from alumni.cs.wisc.edu ([128.105.2.11]:6300 "EHLO
	alumni.cs.wisc.edu") by vger.kernel.org with ESMTP id S263564AbUDMS7t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 14:59:49 -0400
Date: Tue, 13 Apr 2004 13:59:48 -0500
From: Will McDonald <will@upl.cs.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: Iomega REV driver
Message-ID: <20040413185948.GQ9575@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: http://www.upl.cs.wisc.edu/~will/pubkey.asc
X-GPG-Fingerprint: DDD6 4020 6A8C 712E 2211  826C D5F9 D8E5 F433 2B28
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This product (35GB ATAPI/USB2.0 removable disks billed as a tape-replacement
device) was just released yesterday (with Windows-only drivers, of course),
but an (old, from Comdex '03) article [0] stated that:

	"Linux drivers are definitely in the works. While many software companies
	suffer from advanced cases of recto-cranial syndrome when it comes to
	Linux drivers, releasing only binary drivers, or playing games, Iomega
	told me they weren't going to do that. When pressed, they said the drivers
	would be open sourced, and built with the help of the community. They are
	looking forward to helping improve the UDF file system when they hit walls
	with their hardware."

However, google and lkml searches reveal no information in this regard.

Is anyone here familiar with Iomega's development efforts for a linux driver?
Or, does anyone have any other information about the device itself, and how it
will likely fit into the kernel (compression in HW? etc)?

CC's to me are appreciated.
Thanks,
-will

[0] http://www.theinquirer.net/?article=12739

-- 
---------Will McDonald-----------------will@upl.cs.wisc.edu----------
GPG encrypted mail preferred. Join the web-o-trust!  Key ID: F4332B28

