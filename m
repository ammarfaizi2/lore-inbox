Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267003AbRGJSC0>; Tue, 10 Jul 2001 14:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267015AbRGJSCQ>; Tue, 10 Jul 2001 14:02:16 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:53778 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S267003AbRGJSCC>; Tue, 10 Jul 2001 14:02:02 -0400
Message-ID: <3B4B4311.90206@interactivesi.com>
Date: Tue, 10 Jul 2001 13:01:53 -0500
From: Timur Tabi <ttabi@interactivesi.com>
Organization: Interactive Silicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
In-Reply-To: <Pine.LNX.3.95.1010710131403.18337A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

>The kernel has the capability (by design) of addressing anything it
>wants. So, if this is what you mean by "shared", I guess you imply
>that Windows can't address anything it wants? Of course it can.
>

Well, I may have oversimplified it a bit.  My point was that a given 
Windows driver can't just take a 32-bit pointer and pass it to another 
driver and have it just work like that.

-- 
Timur Tabi
Interactive Silicon



