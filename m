Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263810AbUEGV6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbUEGV6c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 17:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUEGV6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 17:58:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:17094 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263810AbUEGV6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 17:58:31 -0400
Date: Fri, 7 May 2004 15:00:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrey Panin <pazke@donpac.ru>
Cc: linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH 0/8] 2.6.3-rc3-mm1, Simplify DMI matching data
Message-Id: <20040507150054.47a21599.akpm@osdl.org>
In-Reply-To: <10839188071828@donpac.ru>
References: <10839188071828@donpac.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, rejects galore again :( There have been a number of changes to
dmi_scan.c since rc3-mm1.  They're probably in rc3-mm2, but it would be
best if you were to base these patches off Linus's latest tree, and we ask
Len to keep his paws off dmi_scan.c for a while.

It might be best to merge these patches via Len's tree anyway - I'll then
pick them up via his tree and they'll hit Linus's tree when Len does the
next ACPI merge?
