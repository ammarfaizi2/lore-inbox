Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbSLKQCT>; Wed, 11 Dec 2002 11:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267197AbSLKQCT>; Wed, 11 Dec 2002 11:02:19 -0500
Received: from dhcp5.colorado-research.com ([65.171.192.245]:13701 "EHLO
	dhcp5.colorado-research.com") by vger.kernel.org with ESMTP
	id <S267196AbSLKQCS>; Wed, 11 Dec 2002 11:02:18 -0500
Message-ID: <3DF7635B.3020900@cora.nwra.com>
Date: Wed, 11 Dec 2002 09:10:03 -0700
From: Orion Poplawski <orion@cora.nwra.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: scott@thomasons.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops on linux 2.4.20-ac1
References: <3DF6291C.3090100@cora.nwra.com> <1039554145.14175.70.camel@irongate.swansea.linux.org.uk> <200212102000.54287.scott@thomasons.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scott thomason wrote:

>I have two AMD MP 2000+ cpus in an ASUS A7M266-D. Even after returning 
>my memory for new chips the store owner memtest86'd, my combo of cpus 
>and mobo was finding the occasional error. I finally ended up 
>resolving it by simply underclocking the bus about 6Mhz :( 
>
>Next time, I'm buying ECC memory.
>---scott
>  
>

Underclocking has been my "solution" to these lockups as well.  Would 
ECC memory actually help in this case though?

