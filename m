Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751880AbWI1QBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbWI1QBX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbWI1QBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:01:22 -0400
Received: from mx.pathscale.com ([64.160.42.68]:55733 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751225AbWI1QBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:22 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 0 of 28] ipath patches for 2.6.19
Message-Id: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 08:59:56 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Roland -

This patch series brings the ipath driver almost up to date with what's
in our internal tree.  The only substantial thing missing is the
memcpy_cachebypass patch that I sent out a while back and haven't had
time to rework.

These patches have seen a lot of testing, including on a git snapshot
as of yesterday afternoon.  Please apply.

Thanks,

	<b
