Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVELXBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVELXBP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 19:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVELXBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 19:01:15 -0400
Received: from mail.dvmed.net ([216.237.124.58]:209 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262168AbVELXBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 19:01:12 -0400
Message-ID: <4283E034.90904@pobox.com>
Date: Thu, 12 May 2005 19:01:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Experimental git repositories available for SATA
References: <4283C2F8.6020801@pobox.com>
In-Reply-To: <4283C2F8.6020801@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>> [jgarzik@pretzel libata-dev]$ ls .git/refs/heads/
>> adma        atapi-enable        iomap        pdc2027x
>> adma-mwi    bridge-detect       iomap-step1  pdc20619
>> ahci-atapi  chs-support         master       promise-sata-pata
>> ahci-msi    ioctl-get-identity  passthru     sil24

For libata-dev.git, I moved these into the main (.git) directory, so 
that things work a bit easier with Linus's scripts.

	Jeff


