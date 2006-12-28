Return-Path: <linux-kernel-owner+w=401wt.eu-S1754860AbWL1PEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbWL1PEl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 10:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754861AbWL1PEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 10:04:41 -0500
Received: from thccv19.oz.nthu.edu.tw ([140.114.63.219]:65000 "EHLO
	thccv19.oz.nthu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860AbWL1PEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 10:04:41 -0500
X-Greylist: delayed 1092 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Dec 2006 10:04:40 EST
From: "Yu-Chen Wu" <g944370@oz.nthu.edu.tw>
To: <linux-kernel@vger.kernel.org>
Subject: How to get the processor ID at run-time?
Date: Thu, 28 Dec 2006 22:46:27 +0800
Message-ID: <001301c72a8e$f411ac30$0100a8c0@sslabmayasky>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccqjvPHX4J/KntMTK+sHwyIpGLRgQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
	I am writing a kernel module that creates a kernel thread on a SMP
platform.
 How to get the ID of the processor the kernel thread run on? Have any
kernel API?   THX
Raymond



