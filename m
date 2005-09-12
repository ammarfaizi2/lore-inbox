Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbVILPAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbVILPAz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbVILO77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:59:59 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:26887 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751370AbVILO7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:59:52 -0400
Date: Mon, 12 Sep 2005 10:48:52 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: akpm@osdl.org, jgarzik@pobox.com
Subject: [patch 2.6.13 0/3] 3c59x misc fixes
Message-ID: <09122005104852.31469@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A collection of patches for the 3c59x driver:

	-- Add bounds checking for hw_checksums array

	-- Use cleaner method for array initialization

	-- Fix some typos in the module param descriptions

Patches to follow...
