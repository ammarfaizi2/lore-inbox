Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284779AbRLEXS3>; Wed, 5 Dec 2001 18:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284810AbRLEXST>; Wed, 5 Dec 2001 18:18:19 -0500
Received: from ppp55-cwdsl.fr.cw.net ([62.210.100.55]:43534 "EHLO
	calvin.paulbristow.lan") by vger.kernel.org with ESMTP
	id <S284779AbRLEXSC>; Wed, 5 Dec 2001 18:18:02 -0500
Message-ID: <3C0EAB5C.4040802@paulbristow.net>
Date: Thu, 06 Dec 2001 00:18:52 +0100
From: Paul Bristow <paul@paulbristow.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: joeja@mindspring.com
CC: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.x 2.5.x wishlist
In-Reply-To: <Springmail.105.1007593036.0.46637500@www.springmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

joeja@mindspring.com wrote:

> Well now that 2.5 is open I thought I'd add this to the wish list.  
> 
> 1) I wish that ECC/ECP/IEEE 1294 would be fixed in 2.4 and 2.5 and work right as this is causing problems in some webcams that worked in 2.2.x but now no longer work in 2.4.  And since just about every major distribution is shipping 2.4 it makes it a little harder to use a 2.2 kernel if you get a dsitro as many are tuned to 2.4 and often don't work right with 2.2.  This actually killed my web cam somewhere around 2.4.10~13.14?
> 
> 2) The nasty VIA ide-floppy / iomega zip 100 drive bugs would get fixed as well as this prevents people from using their zip drives under Linux   and forces them to use them under another OS.


I have a patch out, and am trying to convince Marcelo to include it.  I 
*DO* know about this as I get lots of the mail complaining about it.  If 
you are suffering, please try with the patch

Marcelo, can we put the ide-floppy patch in the next 2.4.17-pre?  I'll 
happily send you the patch again.

 
> just my .02 cents

and my 0.02 euros :-)



-- 

Paul

ide-floppy maintainer

Email: 
paul@paulbristow.net
Web: 
http://paulbristow.net
ICQ: 
11965223

