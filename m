Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVEJJ0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVEJJ0c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 05:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVEJJ0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 05:26:31 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:38556 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261592AbVEJJ0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 05:26:30 -0400
Message-ID: <9FCDBA58F226D911B202000BDBAD46738CFF9D@zch01exm40.ap.freescale.net>
From: Chen Bill-R63518 <zwchen@freescale.com>
To: linux-kernel@vger.kernel.org
Subject: Disable cached memory
Date: Tue, 10 May 2005 17:26:18 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
When I cat "/proc/meminfo", I found there were too many memory cached which may result in kernel oom and killing something. I want to disable the cacheable feature, or limit the maximum of memory sizes which could be used for cached data. But anyone know how I shall do in the kernel? I use 2.4.20 kernel. Thanks.

--
Bill
