Return-Path: <linux-kernel-owner+w=401wt.eu-S1751441AbXAFRAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbXAFRAF (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 12:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbXAFRAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 12:00:05 -0500
Received: from smtpauth02.prod.mesa1.secureserver.net ([64.202.165.182]:34693
	"HELO smtpauth02.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751441AbXAFRAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 12:00:00 -0500
Message-ID: <459FD585.70400@seclark.us>
Date: Sat, 06 Jan 2007 11:59:49 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kay Sievers <kay.sievers@vrfy.org>
CC: Greg KH <greg@kroah.com>, Yakov Lerner <iler.ml@gmail.com>,
       Kernel Linux <linux-kernel@vger.kernel.org>
Subject: Re: how to get serial_no from usb HD disk (HDIO_GET_IDENTITY ioctl,
 hdparm -i)
References: <f36b08ee0701041427u7aee90b7j46b06c3b7dd252bd@mail.gmail.com>	 <20070106045147.GA6081@kroah.com> <3ae72650701060715q4f036274xb6f8b664ab3233c@mail.gmail.com>
In-Reply-To: <3ae72650701060715q4f036274xb6f8b664ab3233c@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers wrote:

>On 1/6/07, Greg KH <greg@kroah.com> wrote:
>  
>
>>On Fri, Jan 05, 2007 at 12:27:34AM +0200, Yakov Lerner wrote:
>>    
>>
>>>How can I get serial_no from usb-attached HD drive ?
>>>      
>>>
>>use the *_id programs that come with udev, they show you how to properly
>>do that.
>>    
>>
>
>Only "advanced" ATA-USB bridges will offer you the serial number the
>adapter reads from the disk on power-up. The usual id-tools will just
>work fine on theses bridges.
>
>There is no way to reach that information with most of the cheap USB
>storage-adapters.
>
>Kay
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
HI Kay,

I am looking to buy a usb to ata adapter can you name some of the 
advanced adapters?

Thanks,
Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



