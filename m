Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWJDX03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWJDX03 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 19:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWJDX03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 19:26:29 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:21889 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751218AbWJDX02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 19:26:28 -0400
Message-Id: <20061004232414.730831000@linux-m68k.org>
User-Agent: quilt/0.45-1
Date: Thu, 05 Oct 2006 01:24:14 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] m68k patches
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here a few miscellaneous fixes for m68k, including the lost timeadj due
the ntp patches, which affected also other archs.

bye, Roman


