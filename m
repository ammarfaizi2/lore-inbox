Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932737AbWF0Ezi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbWF0Ezi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933407AbWF0EyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:54:08 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:41947 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933410AbWF0ElN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:41:13 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 14:41:12 +1000
Subject: [Suspend2][ 00/21] User interface
Message-Id: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These patches add user interface support. We support using
simple printks if no userspace helper is available, or
passing messages through to such a helper.
