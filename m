Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVDMXux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVDMXux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 19:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVDMXun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:50:43 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:36616 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261239AbVDMXoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:44:55 -0400
Date: Wed, 13 Apr 2005 19:38:43 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Cc: jgarzik@pobox.com, davem@davemloft.net
Subject: [patch 2.6.12-rc2 0/10] add bcm5752 support plus some cleanup to tg3
Message-ID: <04132005193843.8300@laptop>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to tg3 for bcm5752 hardware.  Also clean-up a lot
of multi-way if statements and replace them with checks of flags
representing classes of tg3 hardware.

Patches to follow...
