Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268582AbRIBSBN>; Sun, 2 Sep 2001 14:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267852AbRIBSBD>; Sun, 2 Sep 2001 14:01:03 -0400
Received: from mail.triton.net ([216.65.160.10]:9482 "HELO mail.triton.net")
	by vger.kernel.org with SMTP id <S267534AbRIBSAv>;
	Sun, 2 Sep 2001 14:00:51 -0400
Message-ID: <3B9273A2.2000706@lycosmail.com>
Date: Sun, 02 Sep 2001 14:00:02 -0400
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
CC: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: USB trouble w/ 2.4.8-ac12
In-Reply-To: <3B916760.1000104@lycosmail.com> <20010901162130.C26407@kroah.com> <20010901162954.B2828@one-eyed-alien.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dharm wrote:

>The Freecom dongle is well supported for Tape drives (the OnStream USB-30, in particular), but I haven't gotten it working for other devices yet.
>
Well, I don't know how much help I can be, but I am willing (given time 
[atm I'm unemployed, but attempting to remedy that]) to test patches.

>
>I'm just short on time to work on this.... so if someone is offering to help, that would be a good thing.
>
Willing to do what I can.

>
>
>Matt
>
>On Sat, Sep 01, 2001 at 04:21:30PM -0700, Greg KH wrote:
>
>>On Sat, Sep 01, 2001 at 06:55:28PM -0400, Adam Schrotenboer wrote:
>>
>>>Using 2.4.8-ac12, USB modules, and a Philips CDRW400.
>>>
>>>I was able to get it to see the CDRW drive once(and that took a minute 
>>>or three), but mostly it only sees the Freecom USB-IDE bridge.
>>>
>>>How do I get the usb code to probe the ATAPI bridge for the devices 
>>>behind it??
>>>
>>You might try asking on the linux-usb-devel mailing list.  I don't know
>>how well the Freecom bridge device is currently supported in Linux.
>>
>>greg k-h
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>



