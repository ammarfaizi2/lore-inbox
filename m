Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUJLOhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUJLOhc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUJLOfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:35:47 -0400
Received: from ns2.gabswave.net ([193.219.214.10]:3008 "EHLO gabswave.net")
	by vger.kernel.org with ESMTP id S265161AbUJLOeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:34:02 -0400
Message-ID: <001401c4b068$7cb74750$0200060a@STEPHANFCN56VN>
From: "Stephan" <support@bbi.co.bw>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: <linux-kernel@vger.kernel.org>
References: <006901c4b05a$3dddd570$0200060a@STEPHANFCN56VN> <20041012141123.GA18579@stusta.de>
Subject: Re: Problem compiling linux-2.6.8.1......
Date: Tue, 12 Oct 2004 16:33:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-gabswave.net-MailScanner-Information: Please contact the ISP for more information
X-gabswave.net-MailScanner: Found to be clean
X-MailScanner-From: support@bbi.co.bw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried to recompile the kernel and watched very carefully for anything 
out off the ordinary but could not find anything that might relate to an 
error message.

Is there anything specific I should keep any eye out for?

Kind Regards
Steph


----- Original Message ----- 
From: "Adrian Bunk" <bunk@stusta.de>
To: "Stephan" <support@bbi.co.bw>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, October 12, 2004 4:11 PM
Subject: Re: Problem compiling linux-2.6.8.1......


> On Tue, Oct 12, 2004 at 02:51:20PM +0200, Stephan wrote:
>
>> I'm trying to compile linux-2.6.8.1 but I'm getting the following error
>> when doing a make.
>>
>>  LD      .tmp_vmlinux1
>> ld: cannot open kernel/built-in.o: No such file or directory
>> make: *** [.tmp_vmlinux1] Error 1
>>
>> Any ideas would be apreciated.
>
> This shouldn't be the first error.
>
> Did you observe any other errors before?
>
>> Kind Regards
>
> cu
> Adrian
>
> -- 
>
>       "Is there not promise of rain?" Ling Tan asked suddenly out
>        of the darkness. There had been need of rain for many days.
>       "Only a promise," Lao Er said.
>                                       Pearl S. Buck - Dragon Seed
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


