Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVGCNmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVGCNmg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 09:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVGCNmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 09:42:36 -0400
Received: from dunaweb1.euroweb.hu ([195.184.0.6]:58763 "EHLO
	szolnok.dunaweb.hu") by vger.kernel.org with ESMTP id S261422AbVGCNmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 09:42:33 -0400
Message-ID: <42C7EFA3.8010809@freemail.hu>
Date: Sun, 03 Jul 2005 16:01:07 +0200
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: hu-hu, hu, en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [2.6 patch] SCSI_SATA has to be a tristate
References: <42C6C5CE.50203@freemail.hu> <20050702214351.GB5346@stusta.de>
In-Reply-To: <20050702214351.GB5346@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk írta:
> On Sat, Jul 02, 2005 at 06:50:22PM +0200, Zoltan Boszormenyi wrote:
>>*** Warning: "ata_device_add" [drivers/scsi/sata_vsc.ko] undefined!
>>...
>>.config is attached.
> 
> 
> Thanks for this report, the fix is below.

Thanks, now sata_via and sata_promise load correctly on my machine.

Best regards,
Zoltán Böszörményi
