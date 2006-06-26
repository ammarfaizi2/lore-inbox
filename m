Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWFZQrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWFZQrn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWFZQre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:47:34 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:33253 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750793AbWFZQrZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:47:25 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 02:47:29 +1000
Subject: [Suspend2][ 0/7] Proc file support
Message-Id: <20060626164729.10724.37131.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Generic routines for implementing the /proc/suspend2 files that allow
the user to configure and tune the subsystem according to their needs.
