Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266051AbRGGHdE>; Sat, 7 Jul 2001 03:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266058AbRGGHcy>; Sat, 7 Jul 2001 03:32:54 -0400
Received: from cmailg6.svr.pol.co.uk ([195.92.195.176]:22534 "EHLO
	cmailg6.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266051AbRGGHcl>; Sat, 7 Jul 2001 03:32:41 -0400
Message-ID: <3B46BB0A.4090600@humboldt.co.uk>
Date: Sat, 07 Jul 2001 08:32:26 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i686; en-US; rv:0.9+) Gecko/20010531
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Ariel Molina Rueda <amolina@fismat.umich.mx>, linux-kernel@vger.kernel.org
Subject: Re: Via82cxxx Codec rate locked at 48Khz
In-Reply-To: <Pine.LNX.4.33.0107061215400.32589-100000@garota.fismat.umich.mx> <3B46038D.5DA023B6@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:


> For the message "Codec rate locked at 48Khz", that is a hardware
> limitation of your codec.  You need to find software which supports
> software rate conversion, so that you may play music at speeds other
> than 48Khz.


One of the symptoms of broken communication with the codec was often 
false reporting of codec capabilities. So I'd recommend trying 2.4.6, to 
see if the codec really is locked at 48kHz.

-- 
Adrian Cox   http://www.humboldt.co.uk/

