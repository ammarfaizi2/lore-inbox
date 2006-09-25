Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWIYI0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWIYI0w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 04:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWIYI0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 04:26:52 -0400
Received: from server6.greatnet.de ([83.133.96.26]:2743 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1750736AbWIYI0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 04:26:52 -0400
Message-ID: <451792E2.2020800@nachtwindheim.de>
Date: Mon, 25 Sep 2006 10:27:14 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: droping a patch in mm
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Would you please drop:
pci_module_init_conversion-in-scsi-subsys-2nd-try.patch
cause it the moving of libata now it will only produce a lot of errors.
I'll rewrite it today.

Thanks,
Henrik Kretzschmar

