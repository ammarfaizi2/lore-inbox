Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290570AbSAYF7p>; Fri, 25 Jan 2002 00:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290575AbSAYF7f>; Fri, 25 Jan 2002 00:59:35 -0500
Received: from mail001.syd.optusnet.com.au ([203.2.75.244]:19855 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S290570AbSAYF7a>; Fri, 25 Jan 2002 00:59:30 -0500
Message-ID: <3C50F43D.90707@bigpond.com>
Date: Fri, 25 Jan 2002 16:59:25 +1100
From: Brendan J Simon <brendan.simon@bigpond.com>
Reply-To: brendan.simon@bigpond.com
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.5) Gecko/20011024
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux console at boot
In-Reply-To: <CHEKKPICCNOGICGMDODJKEPAGBAA.george@gator.com> <200201250550.g0P5o1L09511@home.ashavan.org.>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Timothy Covell wrote:

>On Thursday 24 January 2002 23:05, George Bonser wrote:
>
>>Is there any way to stop the console scrolling during boot? My reason
>>for this is I am trying to troubleshoot a boot problem with
>>2.4.18-pre7 and I would like to give a more useful report than "it
>>won't boot" but the screen outputs information every few seconds and I
>>can't "freeze" the display so I can copy down the initial error(s).
>>
>>This is an Intel unit using the standard console (not serial console).
>>pre7 will not boot but pre6 boots every time.
>>
Try <ctrl>s to stop the display scrolling and <ctrl>q to restart it.

Regards,
Brendan Simon.


