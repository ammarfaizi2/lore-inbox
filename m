Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264659AbSLEQ3w>; Thu, 5 Dec 2002 11:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbSLEQ3k>; Thu, 5 Dec 2002 11:29:40 -0500
Received: from ermelo.utad.pt ([193.136.40.6]:39884 "EHLO marao.utad.pt")
	by vger.kernel.org with ESMTP id <S264001AbSLEQ3c>;
	Thu, 5 Dec 2002 11:29:32 -0500
Message-ID: <3DEF7EEC.9040906@alvie.com>
Date: Thu, 05 Dec 2002 16:29:32 +0000
From: Alvaro Lopes <alvieboy@alvie.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: Brendon Higgins <bh_doc@users.sourceforge.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: dvd-drive no longer works (2.4.20)
References: <200212051151.59330.bh_doc@users.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brendon Higgins wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Hello. I have a problem since upgrading linux from 2.4.19 to 2.4.20. During 
>boot, the kernel spits out several "status error" and other messages about my 
>dvd and cdrw drives (both on ide1).
>  
>
Could you activate the kernel config option "Enable DMA only for disks" 
and see if it still happens?

Álvaro




