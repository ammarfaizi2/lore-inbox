Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVKKIlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVKKIlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVKKIgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:36:06 -0500
Received: from i121.durables.org ([64.81.244.121]:5070 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932233AbVKKIgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:36:02 -0500
Date: Fri, 11 Nov 2005 02:35:48 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
Message-Id: <1.282480653@selenic.com>
Subject: [PATCH 0/15] misc: Miscellaneous bits from -tiny
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a set of fairly straightforward patches from the -tiny tree.

They're largely independent, except that several of them touch
init/Kconfig and the second panic related patch does depend on the
first one.

This work is sponsored in part by the CE Linux Forum.
