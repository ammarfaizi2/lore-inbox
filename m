Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263294AbTIVUrK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbTIVUrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:47:10 -0400
Received: from continuum.cm.nu ([216.113.193.225]:32640 "EHLO continuum.cm.nu")
	by vger.kernel.org with ESMTP id S263294AbTIVUrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:47:07 -0400
Date: Mon, 22 Sep 2003 13:47:03 -0700
From: Shane Wegner <shane@cm.nu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23-pre5 crash
Message-ID: <20030922204703.GA1490@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-No-Archive: yes
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a quick note to report that my system does not run
stably under 2.4.23-pre5 where pre4 worked fine.  The
system locks up usually during the execution of the rc
scripts.  It's gotten fully booted a couple times but never
lasts longer than 5 minutes.  When the lockup occurs, there
is no oops, panic, or the like, system just stops
responding.

The system is an Intel sds2 mainboard in a dual Pentium III
configuration with acpi enabled.  If you need any other
information, lspci, dmesg, etc.  Let me know.

S
