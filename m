Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUIMCiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUIMCiR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 22:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUIMCiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 22:38:17 -0400
Received: from mailadmin.WKU.EDU ([161.6.18.52]:13202 "EHLO mailadmin.wku.edu")
	by vger.kernel.org with ESMTP id S264997AbUIMCiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 22:38:16 -0400
From: "Bikram Assal" <bikram.assal@wku.edu>
Subject: Tuning  max_thread_proc kernel parameter
To: linux-kernel@vger.kernel.org
Cc: jonathan.davis@wku.edu
X-Mailer: CommuniGate Pro WebUser Interface v.4.1.8
Date: Sun, 12 Sep 2004 21:38:15 -0500
Message-ID: <web-77847225@mailadmin.wku.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question regarding finding value for kernel parameters.
How can we find the values for max_thread_proc and nkthread kernel parameters ? Which file do I need to look up ?

I'm running RedHat Enterprise Linux server and am trying to figure out the current limit set for maximum threads per process and the kernel threads nkthread.

Is there a different kernel parameter that tells the value for allowed no of threads per process other than max threads parameter ?

In case the values are low, is it possible to increse these values as some of the applications running on the server create hundreds of threads (WebLogic) ??

Thanks for your help.

- Bikram.

