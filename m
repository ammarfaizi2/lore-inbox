Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUHIUM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUHIUM3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267191AbUHIULz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:11:55 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:41912 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S267190AbUHIUIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:08:25 -0400
Message-ID: <4117DA2C.8070103@blue-labs.org>
Date: Mon, 09 Aug 2004 16:10:20 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040809
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: hda: dma_timer_expiry: dma status == 0x24
References: <41152B61.90702@blue-labs.org> <1091915230.19077.11.camel@localhost.localdomain>
In-Reply-To: <1091915230.19077.11.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------030101040706080705090907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030101040706080705090907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Yes, it still occurs with acpi=off, albeit with far less frequency.  
I've had my machine up for 1.5 hours now, ripping two CDs at a time, 
playing an AVI movie in loop, playing a bunch of MP3s, cat /allfiles 
 >/dev/null, ls -laR, running KDE with numerous KDE apps also running; 
all simultaneously.  The load is about 8, I'm 130M into swap (512M machine)

1> This would have been impossible without acpi=off.
2> Only one timeout has occured, by now several hundred would have 
normally happened

David

Alan Cox wrote:

>On Sad, 2004-08-07 at 20:20, David Ford wrote:
>  
>
>>My desktop is experiencing issues with DMA lately.  This has been going 
>>on with the 2.6.8-rcX releases IIRC.  I'm currently on rc3.  The 
>>hardware is all brand new.
>>    
>>
>
>1. Does it recover after the timeout/lost irq
>2. Does it occur with acpi=off
>3. Have you tested say 2.4 or "otherOS" on it ?
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

--------------030101040706080705090907
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------030101040706080705090907--
