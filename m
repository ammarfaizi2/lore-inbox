Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUDCIk2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 03:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUDCIk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 03:40:28 -0500
Received: from lbo.net1.nerim.net ([62.212.103.219]:441 "EHLO gyver.homeip.net")
	by vger.kernel.org with ESMTP id S261631AbUDCIk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 03:40:26 -0500
Message-ID: <406E787B.30308@inet6.fr>
Date: Sat, 03 Apr 2004 10:40:27 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Mas <roland.mas@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Drivers *dropped* between releases? (sis5513.c)
References: <1GDM3-6G3-5@gated-at.bofh.it> <1GFEd-8b8-15@gated-at.bofh.it> <87zn9t1nju.fsf@mirexpress.internal.placard.fr.eu.org>
In-Reply-To: <87zn9t1nju.fsf@mirexpress.internal.placard.fr.eu.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Mas wrote the following on 04/03/2004 10:19 AM :

>[...]
>  More relevant info (maybe): I got an old version of the Debian
>installer, which uses an older kernel, and the process goes on
>normally (well, it halts later because the built-in NIC has a stupid
>MAC address, but that's another problem).
>
>  
>

If you can find the time, please check that this old installer doesn't 
use the sis5513 driver or DMA transfers. If it does both, I'd be really 
interested by the exact kernel version used. If it doesn't, you'd 
probably found yourself a workaround by disabling dma at boot time.

Best regards,

-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
   o              Siege social: 51, rue de Verdun - 92158 Suresnes
  /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
 / /\  /_  / /_   France
 \/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
  Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10
 

