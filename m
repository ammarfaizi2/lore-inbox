Return-Path: <linux-kernel-owner+w=401wt.eu-S932908AbWL0FDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932908AbWL0FDb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 00:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932910AbWL0FDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 00:03:31 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:40169 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932908AbWL0FDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 00:03:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=ewVpsz/Orbj1Whi8B/lcqvW+bksxcH9OGZ2btCpDuOTdC1qiJ98jbcLZ+8TtzNYdhJr94F44NGwts/hojlvBAz2pf1ywMc8I2s83AVd3MCnDRkLQtvfabsUpQ3fTH3Spm/YqNppE++hxp9kRJCC++xv5SFi0wi3Y7mPiQxZ1Gf0=
Message-ID: <4591FE96.1080606@gmail.com>
Date: Wed, 27 Dec 2006 14:03:18 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Harald Dunkel <harald.dunkel@t-online.de>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
References: <45841710.9040900@t-online.de> <4587F87C.2050100@gmail.com> <45883299.2050209@t-online.de> <45887CD8.5090100@gmail.com> <458AE5FB.7080607@t-online.de>
In-Reply-To: <458AE5FB.7080607@t-online.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:
> Hi Tejun,
> 
> Tejun Heo wrote:
>> * dmesg is truncated, please post the content of file /var/log/boot.msg.
>>
>> * Please post the result of 'lspci -nnvvv'
>>
>> * Please try the attached patch and see if it makes any difference and
>> post the result of 'dmesg' after trying to play a problematic dvd.
>>
> 
> It still doesn't work, but the dmesg output looks less
> weird. See attachments.
> 
> 
> Hope this helps. Please mail.

Okay, Hmmm... Weird.  I tried to reproduce it here w/ LG dvd ram and
sil3114 (almost identical, just two more ports) with no success.  I just
ordered SH-S183A and it should arrive later today (zero-day shipping
just at USD 3.5!).

I'll write again when I know more.

-- 
tejun
