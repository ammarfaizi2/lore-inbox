Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269578AbTHSKFk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 06:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269619AbTHSKFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 06:05:40 -0400
Received: from MailBox.iNES.RO ([80.86.96.21]:41352 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id S269578AbTHSKFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 06:05:39 -0400
Date: Tue, 19 Aug 2003 13:05:29 +0300 (EEST)
From: Dumitru Ciobarcianu <cioby@ines.ro>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3-mm3
In-Reply-To: <20030819013834.1fa487dc.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0308191302180.15679-100000@MailBox.iNES.RO>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (MailBox.iNES.RO)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For some reason, the ACPI support depends on local apic.
If you don't set "Local APIC support on uniprocessors" you can't enter in 
the "ACPI Support" menu.

Is this really necessary ?

//Cioby


