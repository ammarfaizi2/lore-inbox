Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUGYXsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUGYXsw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 19:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUGYXsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 19:48:52 -0400
Received: from [61.49.234.179] ([61.49.234.179]:6631 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S264571AbUGYXsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 19:48:51 -0400
Date: Mon, 26 Jul 2004 07:45:10 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200407261445.i6QEjAS04697@freya.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Future devfs plans
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Do not delete devfs.

	devfs allows drivers to be loaded when user level programs
need them,
