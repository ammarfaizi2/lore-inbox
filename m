Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262363AbTCMNbw>; Thu, 13 Mar 2003 08:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262364AbTCMNbw>; Thu, 13 Mar 2003 08:31:52 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:688 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S262363AbTCMNbu>; Thu, 13 Mar 2003 08:31:50 -0500
Message-ID: <20030313134224.27541.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: akpm@digeo.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date: Thu, 13 Mar 2003 14:42:24 +0100
Subject: Re: 2.5.64-mm6
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Andrew Morton <akpm@digeo.com> 
Date: 	Thu, 13 Mar 2003 03:26:15 -0800 
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org 
Subject: 2.5.64-mm6 
 
> . Added all of Russell King's PCMCIA changes.  If anyone tests this on 
>   cardbus/PCMCIA machines please let us know. 
 
Testing 2.5.64-mm6 on my NEC laptop, TI CardBus Bridge, 
3Com 3c575. No problems yet ;-) 
 
>   This means that large cache-cold executables start significantly faster. 
>   Launching X11+KDE+mozilla goes from 23 seconds to 16.  Starting OpenOffice 
>   seems to be 2x to 3x faster, and starting Konqueror maybe 3x faster too.  
>   Interesting. 
 
I feel the system a little bit faster and more responsive. I've also set 
max_timeslice to 50 to experiment a little more with interactive loads. 
 
Thanks! 
 
   Felipe 
 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
