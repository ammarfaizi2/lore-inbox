Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTKPOhc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 09:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbTKPOhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 09:37:32 -0500
Received: from mail.nvc.net ([64.68.160.43]:31504 "EHLO garbanzo.nvc.net")
	by vger.kernel.org with ESMTP id S262827AbTKPOhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 09:37:31 -0500
Message-ID: <3FB78BAF.3060403@dakotainet.net>
Date: Sun, 16 Nov 2003 08:37:35 -0600
From: merwan kashouty <kashouty@dakotainet.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: promise 20376
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i was just wondering if there was any further progress on a possible 
native kernel driver for the promise 20376 sata chip... i have it 
running now but with the proprietary driver from promise's website.... 
but it seems to work well,

 Timing buffer-cache reads:   1692 MB in  2.00 seconds = 846.00 MB/sec
 Timing buffered disk reads:  232 MB in  3.01 seconds =  77.08 MB/sec

much better then the reported silicon image tests i have seen....  i 
hope someone is still talking to promise about releasing the full source 
to get this into the kernel or working to reverse engineer a driver... 
all the information i have found searching lkml seems to be atleast a 
couple of months old.

ciao

merwan

p.s. i am not on the mailing list though do check it frequently but if i 
could be cc'ed aboutthis question that would be great... thanks again

