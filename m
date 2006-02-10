Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWBJK2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWBJK2h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 05:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWBJK2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 05:28:24 -0500
Received: from mail22.bluewin.ch ([195.186.19.66]:15339 "EHLO
	mail22.bluewin.ch") by vger.kernel.org with ESMTP id S1751230AbWBJK17
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 05:27:59 -0500
Cc: linux-kernel@vger.kernel.org, Arthur Othieno <apgo@patchbomb.org>
Subject: [PATCH 0/4] PC98: remove remaining debris.
In-Reply-To: 
X-Mailer: git-send-email
Date: Fri, 10 Feb 2006 05:27:33 -0500
Message-Id: <11395672534150-git-send-email-apgo@patchbomb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Arthur Othieno <apgo@patchbomb.org>
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Arthur Othieno <apgo@patchbomb.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PC98 subarch died a messy one. Cleanup misc remaining debris.
Changelog within.

Signed-off-by: Arthur Othieno <apgo@patchbomb.org>

---

 drivers/block/Makefile          |    1 -
 drivers/input/keyboard/Makefile |    1 -
 drivers/input/misc/Makefile     |    1 -
 drivers/input/serio/Makefile    |    1 -
 drivers/net/8390.h              |    2 +-
 include/sound/opl3.h            |    1 -
 6 files changed, 1 insertion(+), 6 deletions(-)


