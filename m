Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267425AbUHPHls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267425AbUHPHls (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 03:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265743AbUHPHls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 03:41:48 -0400
Received: from gw-oleane.hubxpress.net ([81.80.52.129]:10935 "EHLO
	yoda.hubxpress.net") by vger.kernel.org with ESMTP id S267425AbUHPHld
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 03:41:33 -0400
From: "Sylvain COUTANT" <sylvain.coutant@illicom.com>
To: "'Tom Sightler'" <ttsig@tuxyturvy.com>
Cc: "'Matt Domsch'" <Matt_Domsch@dell.com>,
       "'Linux-Kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: High CPU usage (up to server hang) under heavy I/O load
Date: Sun, 15 Aug 2004 22:30:57 +0200
Organization: ILLICOM
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <1092454748.3816.11.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcSBsHm+73occx3iT0mgQ2UkYb8I+wBVYXNQ
Message-Id: <20040815203153.3EB913074E@illicom.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What driver are you using for the PERC?

Megaraid "2". As far as I know, in newer kernels, this is the only one
compiled in. We have had several problems with the previous one. Also, Matt
Domsch's page state the exact versions you need depending on your system.

Our 1750's work very well using RAID PERC4/DI under 2.4.26's megaraid
driver. Although they are not really stressed ...


> I've been wanting to try the 'megaraid2' driver

Hopefully, Matt will send his advice on the subject, but I think you should
try this asap.

Sylvain.

