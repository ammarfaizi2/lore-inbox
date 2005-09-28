Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbVI1Vyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbVI1Vyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbVI1VyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:54:02 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:34565 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751041AbVI1Vxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:53:33 -0400
Date: Wed, 28 Sep 2005 17:50:51 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, leonid.grossman@neterion.com
Subject: [patch 2.6.14-rc2 0/2] minor cleanups for s2io
Message-ID: <09282005175051.10698@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of minor cleanups for the s2io driver:

	-- Use the target length as the third argument to strncpy
	in s2io_ethtool_gdrvinfo()

	-- Add a MODULE_VERSION entry

Patches to follow...
