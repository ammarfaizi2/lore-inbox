Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266227AbUFUNaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266227AbUFUNaE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 09:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266224AbUFUNaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 09:30:04 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:20904 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S266227AbUFUNaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 09:30:01 -0400
Message-ID: <40D6E204.7050003@ics.muni.cz>
Date: Mon, 21 Jun 2004 15:26:28 +0200
From: Miroslav Ruda <ruda@ics.muni.cz>
Organization: UVT MU
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: cs, en
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>
CC: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com,
       jgarzik@pobox.com
Subject: Re: sata promise problems on x86_64
References: <40D6C80B.2020202@ics.muni.cz> <200406211329.32085.andrew@walrond.org>
In-Reply-To: <200406211329.32085.andrew@walrond.org>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.3.18
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond wrote:
> On Monday 21 Jun 2004 12:35, Miroslav Ruda wrote:
> 
>> I have problems with SATA promise driver from  2.4.27-rc1 on x86_64 arch
>>(MB ASUS SK8V). Kernel 2.4.27-rc1 reports
> 
> 
> I've been having similar problems with an SK8N, but with 2.6.7 kernel. It's 
> ACPI related, and I suspect also effects 2.4. I guess you have ACPI enabled?

I'm successfully running Suse kernel 2.6.5-7.75 with ACPI switched on, but for 2.4.27-rc1 acpi=off apm=off iommu=noforce works ok.

Thanks for your help.

-- 
                  Mirek Ruda 
