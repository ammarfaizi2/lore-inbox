Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVASATG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVASATG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 19:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVASATG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 19:19:06 -0500
Received: from mailgate2.dslextreme.com ([66.51.199.95]:1461 "EHLO
	mailgate2.dslextreme.com") by vger.kernel.org with ESMTP
	id S261499AbVASASf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 19:18:35 -0500
Message-ID: <41EDA734.1040508@colannino.org>
Date: Tue, 18 Jan 2005 16:17:56 -0800
From: James Colannino <lkml@colannino.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: SATA disk dead? ATA: abnormal status 0x59 on port 0xE407
References: <1105830698.15835.16.camel@localhost.localdomain>	 <41EB3F80.5050400@tmr.com> <41EB5ECC.1020105@bigfoot.com>	 <200501170914.46344.m.watts@eris.qinetiq.com> <311601c9050117170161e65147@mail.gmail.com> <41ECAC1E.9010003@bigfoot.com>
In-Reply-To: <41ECAC1E.9010003@bigfoot.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-DSLExtreme-MailGate-Information: Please contact the ISP for more information
X-DSLExtreme-MailGate: Found to be clean
X-MailScanner-From: lkml@colannino.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Steffl wrote:

> Eric Mudama wrote:
>
>> we don't use security torx screws, we use normal ones on our boards.
>>
>> I wouldn't recommend swapping boards, since the code stored on the
>> physical media, the opti tables, and the asic on the board were all
>> processed together at one point and are specific to each other.  The
>> new board may not work properly with the heads in the other drive, and
>> could even cause damage, if both drives were several sigma to opposite
>> sides of each other in the spectrum of passing drives, or had a
>> different head vendor, etc.
>>
>> If the data already appears lost and you've run out of other options,
>> it may prove useful to attempt writing to the entire device without
>> attempting reads.  If the drive then reads normally after that, the
>> damage was probably incurred in some transient fashion (excessive
>> vibration or heat, etc) and the replacement data may eliminate the
>> failures.
>>
>> Either way, however, I would probably recommend just RMA'ing the
>> drives.  We should be able to get you a replacement in a few days from
>> the time you fill out the form.
>
>
>   it's DiamondMax 9 (manufactured june 13 2003), those had only one 
> year warranty so unfortunately I can't return it (just checked it on 
> maxtor.com).
>

Sometimes, if you get a nice person from Maxtor on the phone, you can 
get it RMA'd anyway.  You just have to talk to the right person.  If you 
don't get someone willing to help out, try calling back until you get 
someone else.  I was able to return a drive that was 3 months out of 
warranty.  Yours is a bit more out of date, but you might as well give 
it a shot ;)

James

