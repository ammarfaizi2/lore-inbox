Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275069AbTHRVKV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 17:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275083AbTHRVKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 17:10:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27067 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S275069AbTHRVKR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 17:10:17 -0400
Message-ID: <3F4140AB.8020605@pobox.com>
Date: Mon, 18 Aug 2003 17:10:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.x ACPI updates
References: <20030818190906.GA19067@gtf.org> <20030818205529.GC18599@werewolf.able.es>
In-Reply-To: <20030818205529.GC18599@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> On 08.18, Jeff Garzik wrote:
> 
>>For those without BK, I have extracted Intel's latest 2.4.x ACPI updates
>>into patch form:
>>
>>ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.22-rc2-acpi1.patch.bz2
> 
> 
> The patch has some strange non-ascii chars there:
> - the first hunk changes a don't to a don't (an apostrophe to a non-ascii
>   acute accent...)
> - A für to a fÃ¼r (I see the current fine on a terminal but not the second)
> - Some copyright symbols...
> 
> See the 1st, 3rd and 4th hunks in the changes to Configure.help.


Bug Intel, not me.

I personally think they shouldn't be changing non-ACPI-related 
Configure.help entries at all, and what you point out was one of the 
minor ACPI gaffs I mentioned to Marcelo and Alan.

	Jeff



