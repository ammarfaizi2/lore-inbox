Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262354AbSK0A3a>; Tue, 26 Nov 2002 19:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbSK0A3a>; Tue, 26 Nov 2002 19:29:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39947 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262354AbSK0A33>; Tue, 26 Nov 2002 19:29:29 -0500
Message-ID: <3DE4138E.8060600@zytor.com>
Date: Tue, 26 Nov 2002 16:36:30 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.49: Severe PIIX4/ATA filesystem corruption
References: <as0nq9$vnu$1@cesium.transmeta.com>	<1038357146.2658.105.camel@irongate.swansea.linux.org.uk> 	<3DE40E29.4040408@zytor.com> <1038359021.3267.110.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> The base 2.5.47/8/9 Linus tree PIIX code has had no corruption reports
> (except someone whose box failed memtest86) and its about the most
> tested IDE controller.
> 
> I would be interested to know what happens if you boot a base 2.5.49
> without raid6 adulteration and stress it on your hw there, just to be
> sure.
 >

I will try it once the system gets put back together, which will be in 
about two weeks (we're moving, and today was computer teardown day.) 
All I have ATM is my laptop, which I won't be running experimental stuff 
on :-/

	-hpa


