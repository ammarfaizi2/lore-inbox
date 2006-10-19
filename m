Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161440AbWJSPFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161440AbWJSPFW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161441AbWJSPFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:05:22 -0400
Received: from alnrmhc11.comcast.net ([206.18.177.51]:2209 "EHLO
	alnrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1161440AbWJSPFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:05:21 -0400
Message-ID: <4537942E.10802@comcast.net>
Date: Thu, 19 Oct 2006 11:05:18 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
CC: linux-kernel@vger.kernel.org, ubuntu-devel <ubuntu-devel@lists.ubuntu.com>
Subject: Re: nobody cared about via irq
References: <45366556.7010907@comcast.net>	 <1161195903.21484.16.camel@localhost.localdomain>	 <45369DAB.5080000@comcast.net> <1161210117.4617.0.camel@localhost.portugal>	 <4536CA24.7020409@comcast.net> <1161262860.4556.5.camel@localhost.localdomain>
In-Reply-To: <1161262860.4556.5.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Sergio Monteiro Basto wrote:
> On Wed, 2006-10-18 at 20:43 -0400, John Richard Moser wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>>
>>
>> Sergio Monteiro Basto wrote:
>>> On Wed, 2006-10-18 at 17:33 -0400, John Richard Moser wrote:
>>>
>>>
>>> Sergio Monteiro Basto wrote:
>>>>>> Maybe the best is report on bugzilla and attach dmesg, lspci and
>>>>>> cat /proc/interrupts 
>>>>>>
>>>>>> see if 
>>>>>> http://bugzilla.kernel.org/show_bug.cgi?id=6419
>>>>>> match :)
>>> Oh yes, that looks exactly like it.  :)  Apparently I didn't file an
>>> Ubuntu bug before (was sure I had long ago...), so I've done one and
>>> linked it to kernel bug #6419.
>>>
>>>> Where ? 
>> https://launchpad.net/products/linux/+bug/66820
> 
> where is attach dmesg, lspci and cat /proc/interrupts  ? 
> 

Forgot to do that.  My dmesg is crap, it's got thousands of powernow-k8
complaints filling most of it, I'm lucky the irq message wasn't pushed
out of the buffer.

> 
> btw your comcast reject my emails 

Huh.  Weird.
>>>>>> Let me know if you do a bugzilla report 
>>>>>> --
>>>>>> Sérgio M. B. 
>>>>>>
> 
> 
> 

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRTeULAs1xW0HCTEFAQICcw//YuoybGPoZzlx+X1fm4UjU73B+lZMNtgw
vZW5f4fDzVz7No3jEY+x6X0LUUliNhSsUxwW5KHXMbHsz4Z2ixwFzhRHLTMXM7PK
u7H2QLJyIR2RFOWHWXG/0Yn3oZI0n2TAx0Ueu1rTy5JfI2aH6ZGpatoeX0vU6I7X
9dRMm7spU1hj4lYpCuIFwS3WEvF1W1uP364N4Hcx8NtzAo0Iv9dbXZXjpHDE7dFI
r90lOAc+SFPkte0DX2K9eI0RrGgrZTe2mSTym3Tt3pO6bDlLsib6HhWqZmX9Uelu
yYgZlE2Ob3w5IGjlPeorLZneCC9hUD/19XM1w0YIUcKtx+hj/OF/G8/QnhA2e4PI
ErayvTgfZxhm9zrSoZqoCOmj6NjS2kIm5hrSEDMWgnzM+kgQUr/vbzq68HT+66sT
d22Teb7rTNnQEv4P32F99aEEKGNE7sSAcgXgiqvjQ+/HNKRX/rJCs0qpuxlGdYxp
hWwdLr4XtR522jCTS4/MxF0+OxufUOtHImOyDFlbqzPVD59m4y575A/p+8W+HUtx
xjQy5QPARxUVX8I0k6va7WR6aeEjAVzXzCKkIBkgNzdof5+PXFGntvGo7M192AP1
PWH2+BOL6WmVi9BZXByeBpqcnWRH7jK1dml5BEMK8zfiZxHxGT/LOUpMHRDz8tGA
9B9/NME3K0A=
=LkjJ
-----END PGP SIGNATURE-----
