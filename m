Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129183AbQK3UXF>; Thu, 30 Nov 2000 15:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129255AbQK3UWq>; Thu, 30 Nov 2000 15:22:46 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:24766 "EHLO
        smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
        id <S129183AbQK3UWo>; Thu, 30 Nov 2000 15:22:44 -0500
Message-ID: <3A26AFC2.833A7DCE@haque.net>
Date: Thu, 30 Nov 2000 14:51:30 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Timothy A. DeWees" <whtdrgn@mail.cannet.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: DVD on Linux
In-Reply-To: <002a01c05ae5$e4fefa60$7930000a@hcd.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Turn on UDF support under filesystems.

mount -t udf /dev/foo /mnt/bar

"Timothy A. DeWees" wrote:
>     Can someone please point me to a doc on how to mount a DVD drive.
> COrrect me if I am wrong but the DVD file format is UDF?  I did not see that
> as an option when I compiled 2.2.17.  Do I need to use 2.4.0testX to mount
> DVD's?  Thanks in advance!
> 

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
