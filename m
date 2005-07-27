Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVG0W0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVG0W0f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVG0WYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:24:09 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:46273 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S261200AbVG0WXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 18:23:33 -0400
Date: Thu, 28 Jul 2005 00:26:18 +0200
From: Florian Engelhardt <flo@dotbox.org>
To: linux-kernel@vger.kernel.org
Subject: powersave not working with amd64 on nforce 4 board
Message-ID: <20050728002618.70fab8e0@localhost>
X-Mailer: Sylpheed-Claws 1.9.13cvs2 (GTK+ 2.6.7; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

powersaving is not working with a 2.6.12-rc3-mm1 kernel and a amd64
3500+ on a nvidia nforce 4 mainboard.
syslog tells me the following about it:

...
ACPI: Processor [CPU0] (supports 8 throttling states)
...
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.40.2)
acpi_processor-0252 [04] acpi_processor_get_per: Error evaluating _PSS
powernow-k8: BIOS error - no PSB or ACPI _PSS objects
acpi_processor-0252 [04] acpi_processor_get_per: Error evaluating _PSS

kind regards

flo

-- 
"I may have invented it, but Bill made it famous"
David Bradley, who invented the (in)famous ctrl-alt-del key combination
