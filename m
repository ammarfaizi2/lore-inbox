Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030696AbWF0Er3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030696AbWF0Er3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030700AbWF0Er1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:47:27 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:53211 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030696AbWF0Em1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:42:27 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 14:42:26 +1000
Subject: [Suspend2][ 00/13] Miscellaneous patches
Message-Id: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These patches add a few files providing general files (version.h etc),
and patch files outside kernel/power to add boot time hooks for
resuming, reserve netlink socket numbers and such like.
