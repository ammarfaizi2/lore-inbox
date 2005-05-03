Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVECTeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVECTeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 15:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVECTeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 15:34:08 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:29832 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261633AbVECTeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 15:34:06 -0400
From: kernel-stuff@comcast.net (Parag Warudkar)
To: "Amanulla G" <amanulla@india.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: /proc on 2.4.21 & 2.6 kernels....
Date: Tue, 03 May 2005 19:34:04 +0000
Message-Id: <050320051934.4818.4277D22B000C7FDD000012D2220075074400009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I checked the top output, it says, global cpu util is 99.% but the cpu
>utilization of a.out is 0.0!!

Works fine on 2.6.11-x86 and recent procps(top attributes 98.7% CPU to a.out and Cumulative CPU is 99%) Possibly you have a outdated procps?

Parag
