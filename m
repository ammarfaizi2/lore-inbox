Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVBPVDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVBPVDT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 16:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVBPVDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 16:03:19 -0500
Received: from giesskaennchen.de ([83.151.18.118]:51394 "EHLO
	mail.uni-matrix.com") by vger.kernel.org with ESMTP id S261911AbVBPVDO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 16:03:14 -0500
Message-ID: <4213B519.7040202@giesskaennchen.de>
Date: Wed, 16 Feb 2005 22:03:21 +0100
From: Oliver Antwerpen <olli@giesskaennchen.de>
User-Agent: Mozilla Thunderbird 1.0RC1 (Windows/20041201)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Bug in SLES8 kernel 2.4.x freezing HP DL740/760
References: <4213AB2B.2050604@giesskaennchen.de> <4213B1FC.4020706@tiscali.de>
In-Reply-To: <4213B1FC.4020706@tiscali.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-giesskaennchen.de-MailScanner-Information: Die Giesskaennchen verschicken keine Viren!
X-giesskaennchen.de-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Matthias-Christian Ott schrieb:
> Oliver Antwerpen wrote:
> 
>> SuSE has patched UNICON into the kernel which will cause these servers 
>> to hang when booted with vga=normal. The system will run fine in 
>> fb-mode, but not in plain text.
>
> Well if you don't need unicon, then remove the patch from the .spec file 
> and rebuild the kernel (from the source rpm). Or report it their bug 
> tracking system.

My problem ist, that when I change .config, then I lose my support. So
SuSE or HP have to tell me to do so.

Oliver



