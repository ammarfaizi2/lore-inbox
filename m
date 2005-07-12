Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbVGLVAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVGLVAd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVGLU6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:58:36 -0400
Received: from [212.76.85.122] ([212.76.85.122]:24068 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S262400AbVGLU5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:57:09 -0400
Message-Id: <200507122055.XAA10661@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Con Kolivas'" <kernel@kolivas.org>,
       "'David Lang'" <david.lang@digitalinsight.com>
Cc: "'linux kernel mailing list'" <linux-kernel@vger.kernel.org>,
       "'ck list'" <ck@vds.kolivas.org>
Subject: RE: [ANNOUNCE] Interbench v0.20 - Interactivity benchmark
Date: Tue, 12 Jul 2005 23:55:46 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <Pine.LNX.4.62.0507120507430.9200@qynat.qvtvafvgr.pbz>
Thread-Index: AcWG2+4R2AzVAXhRSW2aNw61O43xlAAR8VUg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005, Con Kolivas wrote:
> It runs a real time high priority timing thread that wakes up the thread

Nice, but why is it threaded?

Forking would be more realistic!


