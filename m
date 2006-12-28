Return-Path: <linux-kernel-owner+w=401wt.eu-S1753692AbWL1UDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbWL1UDY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 15:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753708AbWL1UDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 15:03:24 -0500
Received: from smtp.nokia.com ([131.228.20.170]:42662 "EHLO
	mgw-ext11.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692AbWL1UDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 15:03:23 -0500
Message-ID: <4594240D.7040007@indt.org.br>
Date: Thu, 28 Dec 2006 16:07:41 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: ext Pierre Ossman <drzeus-list@drzeus.cx>
CC: anderson.lizardo@indt.org.br, linux-kernel@vger.kernel.org,
       carlos.aguiar@indt.org.br, tony@atomide.com, david-b@pacbell.net
Subject: Re: [PATCH 4/4] Add MMC Password Protection (lock/unlock) support
 V8: mmc_sysfs.diff
References: <45748173.2050008@indt.org.br> <20061215193717.GA10367@flint.arm.linux.org.uk> <45868C6F.5000804@indt.org.br> <458D39AE.2040207@drzeus.cx> <F26D8BDC5BC8014A909C6D45468F69EF022B6839@mzebe101.NOE.Nokia.com> <4592D989.8070000@drzeus.cx>
In-Reply-To: <4592D989.8070000@drzeus.cx>
X-Enigmail-Version: 0.94.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Dec 2006 20:02:47.0826 (UTC) FILETIME=[25695720:01C72ABB]
X-eXpurgate-Category: 1/0
X-eXpurgate-ID: 149371::061228220140-6687ABB0-5AC5A600/0-0/0-1
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext Pierre Ossman wrote:
> Anderson.Briglia@indt.org.br wrote:
>> Did you see this patch at V9 series? This bug is fixed.
>> I also fixed this code according the latest Russel's comments and will send again at V9, just this patch.
>>
>>   
> 
> The V9 you sent me on the 15th was before Russell pointed out the
> dangling lock, and doesn't contain a fix for it.

Yes, I'm already fixed the latest Russel's comment. I'm preparing it to send again to you and LKML. Do you have other
comments? If the others patches are ok, I intend to send just this mmc_sysfs.diff patch.

Regards,

Anderson Briglia

