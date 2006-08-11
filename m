Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751515AbWHKFJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbWHKFJD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 01:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWHKFJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 01:09:03 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:17844 "EHLO
	asav08.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751190AbWHKFJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 01:09:01 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAI+t20QN
Message-Id: <20060811050310.958962036.dtor@insightbb.com>
Date: Fri, 11 Aug 2006 01:03:10 -0400
From: Dmitry Torokhov <dtor@insightbb.com>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 0/6] Backlight & lcd fixes/cleanups
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

I was looking into intergating backlight support into acpi video
driver (went nowhere so far) and I stumbled across some issues
in backlight/lcd core support which this patch series tries to
address.

Please review and consider applying. Compile-tested only.

--
Dmitry
