Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVADOuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVADOuj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 09:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVADOui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 09:50:38 -0500
Received: from [212.20.225.142] ([212.20.225.142]:58389 "EHLO
	orlando.wolfsonmicro.main") by vger.kernel.org with ESMTP
	id S261665AbVADOuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 09:50:35 -0500
Subject: [PATCH 0/2] AC97 plugin suspend/resume
From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1104850234.9143.331.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 04 Jan 2005 14:50:34 +0000
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jan 2005 14:50:34.0648 (UTC) FILETIME=[BEE7F980:01C4F26C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

These patches add suspend and resume capability for OSS AC97 plugins.
This enables to kernel to power manage codec functionality that doesn't
come under default AC97 e.g. powering down the pen digitiser ADC

Liam 

