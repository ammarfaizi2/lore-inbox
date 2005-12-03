Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVLCSvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVLCSvY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 13:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVLCSvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 13:51:24 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:4308 "EHLO gepetto.dc.ltu.se")
	by vger.kernel.org with ESMTP id S932137AbVLCSvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 13:51:23 -0500
Message-ID: <4391EA5A.50308@student.ltu.se>
Date: Sat, 03 Dec 2005 19:56:26 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Otavio Salvador <otavio@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/11] SCSI: replace all uses of pci_module_init with pci_register_driver
References: <11336254302568-git-send-email-otavio@debian.org>
In-Reply-To: <11336254302568-git-send-email-otavio@debian.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otavio Salvador wrote:

>This patch replace all calls to pci_module_init, that's deprecated and
>will be removed in future, with pci_register_driver that should be
>the used function now.
>  
>
This has already been "done". On November 30th I sent in a patch-set for 
the same task.

Btw, I also sent a patch named "[PATCH] pci: Schedule removal of 
pci_module_init (was ..." today, about 17 hours ago.
Would you mind check it, please?

cu
Richard Knutsson
