Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132945AbRA3XF2>; Tue, 30 Jan 2001 18:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132961AbRA3XFI>; Tue, 30 Jan 2001 18:05:08 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:37131 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132945AbRA3XE7>;
	Tue, 30 Jan 2001 18:04:59 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: root@chaos.analogic.com
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Version 2.4.1 cannot be built. 
In-Reply-To: Your message of "Tue, 30 Jan 2001 17:57:44 CDT."
             <Pine.LNX.3.95.1010130175517.3672A-100000@chaos.analogic.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 31 Jan 2001 10:04:53 +1100
Message-ID: <5363.980895893@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001 17:57:44 -0500 (EST), 
"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>On Wed, 31 Jan 2001, Keith Owens wrote:
>
>> On Tue, 30 Jan 2001 16:45:16 -0500 (EST), 
>> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
>> >The subject says it all. `make dep` is now broken.
>> >make[4]: Entering directory `/usr/src/linux-2.4.1/drivers/acpi'
>> >Makefile:29: *** target pattern contains no `%'.  Stop.
>> 
>> Which version of make are you running?
>> 
>	3.74
>
>y'a mean even make isn't make anymore?

You mean that nobody reads Documentation/Changes any more?

Current Minimal Requirements
o  Gnu make               3.77                    # make --version

PEBCAK.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
