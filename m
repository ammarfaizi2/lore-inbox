Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbRHMTZ0>; Mon, 13 Aug 2001 15:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266606AbRHMTZR>; Mon, 13 Aug 2001 15:25:17 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:57868 "EHLO nyc.rr.com")
	by vger.kernel.org with ESMTP id <S266806AbRHMTZE>;
	Mon, 13 Aug 2001 15:25:04 -0400
Message-ID: <3B782705.2000100@nyc.rr.com>
Date: Mon, 13 Aug 2001 15:14:13 -0400
From: John Weber <weber@nyc.rr.com>
Organization: My House
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Are we going too fast?
In-Reply-To: <fa.l9dq0tv.7gqnhh@ifi.uio.no> <fa.g70as7v.1722ipv@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:

>>of them have suffered from one malady or another - from the dual PIII with
>>the VIA chipset and Matrox G400 card, which locks up nicely when I switch
>>
> 
> Welcome to wacky hardware. To get a G400 stable on x86 you need at least
> 
> XFree86 4.1 if you are running hardware 3D (and DRM 4.1)
> 2.4.8 or higher with the VIA fixes
> Preferably a very recent BIOS update for the VIA box
> 


I'm sorry, but what "VIA fixes" are we referring to?

My hardware:
- VIA  Apollo Pro 133A - VIA VT82C686A South, VIA VT82C693A North

The only problem I have ever had with my system had to do with the 

onboard sound (via82cxxx_audio driver specifically), and Mr. Jeff
Garzik promptly issued a patch which corrected my problem.

I'm currently running linux kernel 2.4.8 with no problems whatsoever.

