Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVCHDiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVCHDiX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 22:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVCGUWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:22:38 -0500
Received: from alephnull.demon.nl ([212.238.201.82]:34180 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S261304AbVCGTrZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:47:25 -0500
Date: Mon, 7 Mar 2005 20:47:19 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linux-kernel@vger.kernel.org
Subject: status of network swapping in linux?
Message-ID: <20050307194719.GA17770@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please CC, not on the list.)

Hi all,

I have an embedded machine that needs a _tiny_ little bit more memory
for some of its tasks than it has.  Unfortunately, it does not have
an IDE or USB controller, but it does have a 10/100 and three gigabit
ethernet interfaces.

There have been a number of efforts in the past for making network
swapping (either via NFS or NBD) work without deadlocking, but most of
those projects appear to have been abandoned.  Is it just too hard to
get right?

Any info appreciated.


thanks,
Lennert
