Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288422AbSAHVbh>; Tue, 8 Jan 2002 16:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288432AbSAHVbb>; Tue, 8 Jan 2002 16:31:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48132 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288422AbSAHVaE>; Tue, 8 Jan 2002 16:30:04 -0500
Message-ID: <3C3B64CA.4020103@zytor.com>
Date: Tue, 08 Jan 2002 13:29:46 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
CC: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB =?iso-8859-1?q?in Configure=2Ehelp=2E?=
In-Reply-To: <Pine.LNX.4.33.0201081324190.23436-100000@sol.compendium-tech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dr. Kelsey Hudson wrote:

> On Sat, 22 Dec 2001, J.A. Magallon wrote:
> 
>>And different length for sea and land 'miles'. Very natural...
>>
> 
> nautical miles are defined as 1852 meters, the exact length of one second 
> of longitude at the equator :)
> 


YM "minute" HTH.


FWIW, from the units database:

nauticalmile            1852 m   # Supposed to be one minute of latitude at
                                 # the equator.  That value is about 1855 m.
                                 # Early estimates of the earth's
circumference
                                 # were a bit off.  The value of 1852 m was
                                 # made the international standard in 1929.
                                 # The US did not accept this value until
                                 # 1954.  The UK switched in 1970.


Of course, the number 21600 is also such a nice round number.

	-hpa


