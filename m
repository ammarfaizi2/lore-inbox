Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318774AbSHQXPX>; Sat, 17 Aug 2002 19:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318775AbSHQXPX>; Sat, 17 Aug 2002 19:15:23 -0400
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:27841 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S318774AbSHQXPW>; Sat, 17 Aug 2002 19:15:22 -0400
Message-ID: <3D5ED96F.50805@linux.org>
Date: Sat, 17 Aug 2002 19:17:03 -0400
From: John Weber <john.weber@linux.org>
Organization: Linux Online
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020702
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: Anton Altaparmakov <aia21@cantab.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Andre Hedrick <andre@linux-ide.org>, axboe@suse.de, vojtech@suse.cz,
       bkz@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: IDE?
References: <Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com> <Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com> <5.1.0.14.2.20020817225323.021796b0@pop.cus.cam.ac.uk> <20020817221704.GA2478@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:
> Em Sat, Aug 17, 2002 at 11:11:14PM +0100, Anton Altaparmakov escreveu:
> 
>>At 20:56 17/08/02, Alan Cox wrote:
>>
>>>Volunteers willing to run Cerberus test sets on 2.4 boxes with IDE
>>>controllers would also be much appreciated. That way we can get good
>>>coverage tests and catch badness immediately
>>
> 
>>If you tell me the kernel version and patches to apply which you want 
>>tested, and what options to run cerberus with (never used it before...), I 
>>have control over a currently idle dual Athlon MP 2000+ with an AMD-768 
>>(rev 04) IDE controller and 3G of RAM. It has only one HD, a ST340810A 
>>(ATA-100, 37G) attached.
> 
> 
> I have a dual p100 with a CMD640 so I'll test 2.4-ac or whatever you name it,
> as soon as I get back from vacation (in two weeks) and I get another old disk
> for this test machine. It behaves with 2.4 but loses a lot of interrupts with
> 2.5-MD (haven't tested after Jens got 2.4 forward port into 2.5).
> 

I have a dual Ppro200 with a PIIX ide chip, and a PIII 866 with a VIA 
686B.  I'll test anything you want on these boxes.


