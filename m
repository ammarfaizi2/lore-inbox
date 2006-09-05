Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965194AbWIERmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbWIERmo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 13:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbWIERmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 13:42:44 -0400
Received: from 71-215-130-30.ptld.qwest.net ([71.215.130.30]:25593 "EHLO
	vonnegut.anholt.net") by vger.kernel.org with ESMTP id S965194AbWIERmn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 13:42:43 -0400
From: Eric Anholt <eric@anholt.net>
To: linux-kernel@vger.kernel.org
Cc: davej@codemonkey.org.uk
Subject: Resubmit: Intel 965 Express AGP patches
Reply-To: Eric Anholt <eric@anholt.net>
Date: Tue, 05 Sep 2006 10:37:32 -0700
Message-Id: <115747785570-git-send-email-eric@anholt.net>
X-Mailer: git-send-email 1.4.1
In-Reply-To: 11551502672606-git-send-email-eric@anholt.net
References: 11551502672606-git-send-email-eric@anholt.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following should be the updated patch series for the Intel 965 Express
support, unless I'm making some mistake with git-send-email.  I think I've
covered Dave's concerns, except for making the PCI ID stuff table-driven.  You
can find a patch for that on the intel-agp-i965 branch at
git://anongit.freedesktop.org/~anholt/linux-2.6

