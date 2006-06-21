Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751583AbWFUOZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWFUOZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbWFUOZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:25:36 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751583AbWFUOZf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:25:35 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 00/21] Series short description
Date: Wed, 21 Jun 2006 16:23:23 +0200
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SD Association decided to release a specification for the SDHCI
controllers. This set of patches updates the current driver, which is
based on reverse engineering, to comply with the official specification.

It has been tested for quite some time by people on the sdhci-devel list.
Although it doesn't solve all known issues, it doesn't cause any new ones.

Rgds
Pierre
