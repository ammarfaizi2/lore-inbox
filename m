Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbULOOpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbULOOpr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 09:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbULOOpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 09:45:47 -0500
Received: from ind-iport-1-sec.cisco.com ([64.104.129.9]:40850 "EHLO
	ind-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S262357AbULOOpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 09:45:44 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Reply-To: <krmurthy@cisco.com>
From: "N.C.Krishna Murthy \(krmurthy\)" <krmurthy@cisco.com>
To: <linux-kernel@vger.kernel.org>
Subject: Limiting memory allocated by buffer cache in 2.4 kernel
Date: Wed, 15 Dec 2004 20:15:35 +0530
Message-ID: <013901c4e2b4$bd041ad0$f8074d0a@apac.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4942.400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I am using linux 2.4.22 kernel. Is there any way to limit the amount
of memory allocated by buffer cache? Eariler versions used to have
/proc/sys/vm/buffermem.

Thanx
NCKM
