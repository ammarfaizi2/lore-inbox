Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWIOHpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWIOHpa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 03:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWIOHpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 03:45:30 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:49805 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750738AbWIOHpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 03:45:30 -0400
From: Philippe Grenard <philippe.grenard@m4x.org>
Reply-To: philippe.grenard@m4x.org
To: Tejun Heo <htejun@gmail.com>
Subject: Re: (Another?) Seagate / Sil3112a problem...
Date: Fri, 15 Sep 2006 09:45:25 +0200
User-Agent: KMail/1.9.4
References: <J5J0S1$E84BD2336C01F896088E954AAF120859@laposte.net> <45096B80.3040303@gmail.com>
In-Reply-To: <45096B80.3040303@gmail.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609150945.26129.philippe.grenard@m4x.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

here are more informations, and i believe now this is not a software problem 
of any kind...

3 things i remarked : 

1/ when changing cables, i still had problems with ata1 : for me, this would 
sound like the controller "ata1" has maybe issues, as ata2 worked before...
2/ when swapping cables, I had problems with ata2 too : this would mean the 
cable had also some issues...
3/ maybe, (but i'm not sure...) the drive needs its own power cable : I mean, 
when the power cable , which contains a "sata plug" and a "ide plug" is 
connected to sata alone, it seems to work better than when the cable is 
connected to both a ide and a sata drive , or the graphic card and the sata 
drive....
since I got a 430 W True Power PSU from Antec, i don't really believe the 
problem is a power problem, but maybe it was too much on one cable??

I'll stop at it, since it seems to work fine, with a config like "1drive -  
ata2 - own power cable". If I go into more troubles, i will try more tests 
and if I arrive to any kind of conclusion, i will let you know about it!

thanks again for the help,

Philippe
