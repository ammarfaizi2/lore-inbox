Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbVIAB2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbVIAB2z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 21:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbVIAB2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 21:28:55 -0400
Received: from ozlabs.org ([203.10.76.45]:32141 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965012AbVIAB2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 21:28:54 -0400
To: <jgarzik@pobox.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 0/18] Updates & bug fixes for iseries_veth network driver
Message-Id: <1125538127.859382.875909607846.qpush@concordia>
Date: Thu,  1 Sep 2005 11:28:53 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a series of patches for the iseries_veth driver. Most of these are
pretty much unchanged since I posted them earlier:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0506.3/1837.html

I've added patches to add sysfs support, and do some further code cleanups.

Please merge if they look ok.

cheers
