Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWFZXIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWFZXIQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWFZXIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:08:15 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:18103 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933262AbWFZWjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:39:09 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 08:39:02 +1000
Subject: [Suspend2][ 00/35] Filewriter
Message-Id: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add the Suspend2 filewriter, which implements support for writing an
image to ordinary files, whether on a filesystem or a raw device.
