Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWEaS0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWEaS0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 14:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWEaS0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 14:26:52 -0400
Received: from rrcs-24-227-247-130.sw.biz.rr.com ([24.227.247.130]:65238 "EHLO
	linux.local") by vger.kernel.org with ESMTP id S1751781AbWEaS0v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 14:26:51 -0400
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH 0/2][RFC] iWARP Core Support
Date: Wed, 31 May 2006 13:26:50 -0500
To: rdreier@cisco.com, mshefty@ichips.intel.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org
Message-Id: <20060531182650.3308.81538.stgit@stevo-desktop>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patchset defines the modifications to the Linux infiniband subsystem
to support iWARP devices.  We're submitting it for review now with the
goal for inclusion in the 2.6.19 kernel.  This code has gone through
several reviews in the openib-general list.  Now we are submitting it
for external review by the linux community.

This StGIT patchset is cloned from Roland Dreier's infiniband.git
for-2.6.18 branch.  The patchset consists of 2 patches:

        1 - New iWARP CM implementation.  
        2 - Core changes to support iWARP.

Signed-off-by: Tom Tucker <tom@opengridcomputing.com>
Signed-off-by: Steve Wise <swise@opengridcomputing.com>
