Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbUBISfi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 13:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUBISfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 13:35:38 -0500
Received: from ibad.dune2.info ([66.28.63.99]:28331 "HELO dune2.info")
	by vger.kernel.org with SMTP id S265335AbUBISfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 13:35:23 -0500
Date: Mon, 9 Feb 2004 19:35:50 -0600
From: leonard <leonard@internetdown.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.2: ACPI -VS- PPPoE / aDSL
Message-Id: <20040209193550.5c7877fd.leonard@internetdown.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

With Linux kernel last 'stable' version 2.6.2,
i had to compile withOUT ACPI to get my PPPoE/aDSL working :/

ACPI works great by itself, but does not let my pppoe driver
(the roaring penguin) do its job properly.
Note I did not try with the new kernel-space pppoe driver. 

It was the same way between ACPI and DHCP in kernel 2.6.0-TEST9

Just letting you know, I'm sure far from being alone with this
issue, but didn't find any messages talking about it in the archives.

Take care ACPI developpers ;)
Guillaume

P.S. Please CC any unlikely answer to `root AT_ dune2 D0T_ info`
that way I'm sure not to skip it :)




