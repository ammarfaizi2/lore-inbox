Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVCYAyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVCYAyv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 19:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVCYAwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 19:52:47 -0500
Received: from ns1.s2io.com ([142.46.200.198]:9609 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S261335AbVCYAqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 19:46:07 -0500
From: "Ravinandan Arakali" <ravinandan.arakali@neterion.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Leonid. Grossman \(E-mail\)" <leonid.grossman@neterion.com>
Subject: Problem applying latest 2.6 kernel prepatch(2.6.12-rc1)
Date: Thu, 24 Mar 2005 16:45:58 -0800
Message-ID: <004001c530d4$034e99d0$3a10100a@pc.s2io.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-Spam-Score: -100
X-Spam-Outlook-Score: ()
X-Spam-Features: USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am trying to submit patches to our driver in the kernel. Since I need a
copy of latest kernel
for this, I installed the latest stable version(2.6.5.11). When I apply the
latest prepatch (2.6.12-rc1)
on top of this, I have the following problems:
1. On application of the prepatch, it reports errors. It looks like some of
the changes that the
    prepatch is trying to apply are already present in 2.6.5.11.
2. If I ignore these errors and complete the patching, the kernel
compilation fails.

Has anybody else seen this problem or am I missing something ?

Thanks,
Ravi

