Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbUKGMjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbUKGMjO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 07:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUKGMjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 07:39:14 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:14598 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S261603AbUKGMjH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 07:39:07 -0500
Date: Sun, 7 Nov 2004 13:38:54 +0100 (CET)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Felipe Alfaro Solana <lkml@mac.com>
cc: andyliu <liudeyan@gmail.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]tar filesystem for 2.6.10-rc1-mm3(easily access tar file)
In-Reply-To: <595C7524-30A7-11D9-8C52-000D9352858E@mac.com>
Message-ID: <Pine.LNX.4.60L.0411071337240.21903@rudy.mif.pg.gda.pl>
References: <aad1205e0411062306690c21f8@mail.gmail.com>
 <595C7524-30A7-11D9-8C52-000D9352858E@mac.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-605554580-1099831134=:21903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-605554580-1099831134=:21903
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 7 Nov 2004, Felipe Alfaro Solana wrote:

> On Nov 7, 2004, at 08:06, andyliu wrote:
>
>>   but with the help of the tarfs,we can mount a tar file to some dir and 
>> access
>> it easily and quickly.it's like the tarfs in mc.
>> 
>>  just mount -t tarfs tarfile.tar /dir/to/mnt -o loop
>> then access the files easily.
>
> Simply wonderful!

Which is ~equal to .. unpack tarfile.tar to /dir/to/mnt :o)

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--8323328-605554580-1099831134=:21903--
