Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbULLWQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbULLWQi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 17:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbULLWOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 17:14:45 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:3237 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262153AbULLWOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 17:14:33 -0500
Date: Sun, 12 Dec 2004 23:14:32 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Improved console UTF-8 support for the Linux kernel?
In-Reply-To: <1102889302.3195.10.camel@kl>
Message-ID: <Pine.LNX.4.61.0412122311150.10353@yvahk01.tjqt.qr>
References: <1102784797.4410.8.camel@kl> <20041211173032.GA13208@fargo> 
 <Pine.LNX.4.53.0412112002020.30929@yvahk01.tjqt.qr>  <1102803807.3183.59.camel@kl>
  <Pine.LNX.4.61.0412120058230.15129@yvahk01.tjqt.qr>  <20041212003857.GA14844@fargo>
 <1102889302.3195.10.camel@kl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-1347535848-1102889672=:10353"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-1347535848-1102889672=:10353
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

>> Aaahh ;), you've should said that before. The whole problem with the
>> kernel is with the compose tables. If you have a native key for "ö" in
>> your keyboard you'll not have problems. I can type for example a 'n
>> with tilde' in my keyboard because is too is a native key, but for
>> accentuated characters, for utf-8 output is neccesary to apply the patch :-/
>
>As soon as the kernel is in Unicode  mode for the console, currently
>there is no way to input accented characters through a dead key
>(composed).
>Some years back when 8-bit encodings where used there was no problem,
>however now all distros are broken with regards to this.

Take it; AFAIK, the DOS box in Windows XP does not support UTF-8 either.

>I do not know what is the next step to consider adding the patch. Do we
>get a kernel maintainer related to console I/O speak up and say "Hmm, I
>*might* consider a patch, if I see it and people say they are happy"?

The proposed patch is working and that's ok. I am happy ÷)
(first composed smiley hehe <compose><:><-><)> )


Jan Engelhardt
-- 
ENOSPC
--1283855629-1347535848-1102889672=:10353--
