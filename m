Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUHJND1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUHJND1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265074AbUHJNDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:03:15 -0400
Received: from genesis.westend.com ([212.117.67.2]:21397 "EHLO
	genesis.westend.com") by vger.kernel.org with ESMTP id S265051AbUHJM7j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:59:39 -0400
Subject: uhci-hcd oops with 2.4.27/ intel D845GLVA
From: Kai Militzer <km@westend.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1092142777.1042.30.camel@bart.intern>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 14:59:37 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone!

> I unable to boot due to a kernel oops on my D845GLVA.  This 
> worked fine in 2.4.26, but with the same (well, except for the 
> new features) config 2.4.27 does not.

I've got the same problem here. Did an make oldconfig from a 2.4.26 
config, booted and the systems made an oops.

Problem is, that the system is production and I can't test, where the 
problem is in special. We had two reboots already and even that is 
nearly too much.

Best regards

Kai

-- 
Kai Militzer                 WESTEND GmbH  |  Internet-Business-Provider
Technik                      CISCO Systems Partner - Authorized Reseller
                             Lütticher Straße 10      Tel 0241/701333-11
km@westend.com               D-52064 Aachen              Fax 0241/911879


