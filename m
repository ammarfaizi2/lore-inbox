Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWCaOZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWCaOZP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 09:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWCaOZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 09:25:14 -0500
Received: from [212.76.92.35] ([212.76.92.35]:60687 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751343AbWCaOZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 09:25:13 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] sched.c : procfs tunables
Date: Fri, 31 Mar 2006 17:23:49 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Cc: linux-smp@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200603311723.49049.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Proper scheduling in a multi-tasking environment is critical to the success 
of a desktop OS.  Linux, being mainly a server OS, is currently tuned to 
scheduling defaults that may be appropriate only for the server scenario.

To enable Linux to play an effective role on the desktop, a more flexible 
approach is necessary.  An approach that would allow the end-User the 
freedom to adjust the OS to the specific environment at hand.

So instead of forcing a one-size fits all approach on the end-User, would not 
exporting sched.c tunables to the procfs present a flexible approach to the 
scheduling dilemma?

All comments that have a vested interest in enabling Linux on the desktop are 
most welcome, even if they describe other/better/smarter approaches.

Thanks!

--
Al

