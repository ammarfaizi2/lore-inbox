Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933328AbWFZWlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933328AbWFZWlL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933318AbWFZWlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:41:10 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:36023 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933314AbWFZWlH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:41:07 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 08:41:05 +1000
Subject: [Suspend2][ 00/28] Swapwriter
Message-Id: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These patches add the swapwriter, which provides the means by which
an image can be written to one or more swap partitions or files.
