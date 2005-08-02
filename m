Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVHBPJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVHBPJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 11:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVHBPJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:09:28 -0400
Received: from vmaila.mclink.it ([195.110.128.108]:20236 "EHLO
	vmaila.mclink.it") by vger.kernel.org with ESMTP id S261566AbVHBPJ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:09:26 -0400
From: "Mauro Tassinari" <mtassinari@cmanet.it>
To: "'Eric W. Biederman'" <ebiederm@xmission.com>,
       "'Linux-Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.12-git8] ACPI shutdown fails to power off machine
Date: Tue, 2 Aug 2005 17:09:25 +0200
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAzEDteH+/jE+9zEg2hJ+/kQEAAAAA@cmanet.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
In-Reply-To: <20050709203402.GA4621@localhost>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The behaviour originally noted, as per object, slightly changed at least
from 2.6.13-rc3, and still goes on in 2.6.13-rc5, regarding MB ASUS
P4P800-E.
Now ACPI still fail to power off that particular MB and reboots it.
Everything works fine for other MBs we use, e.g. ASUS P5GD1 PRO.
If you need more info, please ask.

Best regards,

Mauro Tassinari

C.M.A. Srl



