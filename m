Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129348AbQK2HjW>; Wed, 29 Nov 2000 02:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129414AbQK2HjN>; Wed, 29 Nov 2000 02:39:13 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:60925 "EHLO
        smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
        id <S129348AbQK2HjA>; Wed, 29 Nov 2000 02:39:00 -0500
Message-ID: <3A24AB70.3E9C1B1F@haque.net>
Date: Wed, 29 Nov 2000 02:08:32 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <200011290644.eAT6ibb26028@moisil.dev.hydraweb.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[mhaque@viper mhaque]$ df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda3             12737128   9988400   2101712  83% /
/dev/hda2                46668     15106     29153  35% /boot
/dev/hdd1             44327416  26319188  15756484  63% /home2
none                   8388608     11944   8376664   1% /dev/shm

Yes, exactly 4096 nulls.

Ion Badulescu wrote:
> 1k- or 4k-block filesystem? Also, can you count the nulls to see if
> they are exactly 4096 of them?

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
