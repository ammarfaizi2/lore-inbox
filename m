Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUHATSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUHATSH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 15:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUHATSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 15:18:06 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:40977 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S266133AbUHATSD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 15:18:03 -0400
Date: Sun, 01 Aug 2004 13:16:32 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@fs.tum.de>
cc: James.Bottomley@HansenPartnership.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, luben_tuikov@adaptec.com
Subject: Re: [2.6 patch] let AIC7{9,X}XX_BUILD_FIRMWARE depend on !PREVENT_FIRMWARE_BUILD
Message-ID: <8F889225785C2F3936338C47@aslan.scsiguy.com>
In-Reply-To: <20040801191118.GA7402@mars.ravnborg.org>
References: <20040801185543.GB2746@fs.tum.de> <20040801191118.GA7402@mars.ravnborg.org>
X-Mailer: Mulberry/3.1.6 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The patch below lets AIC7{9,X}XX_BUILD_FIRMWARE depend on 
>> !PREVENT_FIRMWARE_BUILD.
> 
> Justin, I agree with this change. Please let me know if I shall forward
> the patch to Linus, or you will take care.
> 
> 	Sam

Luben Tuikov is the current maintainer of these drivers.

--
Justin

