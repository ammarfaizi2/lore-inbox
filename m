Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316959AbSEaWRz>; Fri, 31 May 2002 18:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316960AbSEaWRy>; Fri, 31 May 2002 18:17:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36624 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316959AbSEaWRx>;
	Fri, 31 May 2002 18:17:53 -0400
Message-ID: <3CF7F60F.40802@mandrakesoft.com>
Date: Fri, 31 May 2002 18:15:43 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikolaus Filus <NFilus@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: de4x5 driver: driver freezes system
In-Reply-To: <20020531233651.B595@nfilus.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikolaus Filus wrote:

>Hi,
>
>I'm a maintainer (one of several :) of a little linux distribution called
>rocklinux (www.rocklinux.org) and tried to make a fits-for-everyone kernel,
>but got some booting problems with the de4x5 driver.
>When compiling the driver into the kernel and no appropriate card is
>installed in the system the booting stops and the computer freezes. I tested
>this with kernel 2.4.16 and .18 on my Toshiba laptop and reported by other
>users. I would like to provide more information, when needed - just say what
>  
>

Does the tulip driver not work for you?

You can try the version in the kernel, or an older version at 
http://sf.net/projects/tulip/

    Jeff





