Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267373AbRGTUoB>; Fri, 20 Jul 2001 16:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267379AbRGTUnl>; Fri, 20 Jul 2001 16:43:41 -0400
Received: from mail-klh.telecentrum.de ([213.69.31.130]:31236 "EHLO
	mail-klh.telecentrum.de") by vger.kernel.org with ESMTP
	id <S267373AbRGTUnd>; Fri, 20 Jul 2001 16:43:33 -0400
Message-ID: <3B587E25.50E3CEB3@topit.de>
Date: Fri, 20 Jul 2001 20:53:25 +0200
From: Ronald Jeninga <rj@topit.de>
Reply-To: rj@topit.de
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gregoire Favre <greg@ulima.unil.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.6-ac5: Filesize limit exceeded
In-Reply-To: <20010720164306.A4977@ulima.unil.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

might be a limit problem, try 

ulimit -f


Ronald


Gregoire Favre wrote:
> 
> Hello,
> 
> I have just turned to 2.4.6-ac5, and I can't create tar bigger than
> 40Mb, I got Filesize limit exceeded...
> 
> Both on ext2 and reiserfs partitions.
> 
> Any idea why?
> 
> Thanks,
> 
>         Greg
> ________________________________________________________________
> http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
> 
>   --------------------------------------------------------------------------------
>    Part 1.2Type: application/pgp-signature
