Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130002AbQK2GGL>; Wed, 29 Nov 2000 01:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130120AbQK2GGC>; Wed, 29 Nov 2000 01:06:02 -0500
Received: from zeus.kernel.org ([209.10.41.242]:46602 "EHLO zeus.kernel.org")
        by vger.kernel.org with ESMTP id <S129792AbQK2GFt>;
        Wed, 29 Nov 2000 01:05:49 -0500
Message-ID: <3A24881D.B2EBA35E@haque.net>
Date: Tue, 28 Nov 2000 23:37:49 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tigran Aivazian <tigran@veritas.com>
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <14877.53881.182935.597766@notabene.cse.unsw.edu.au>
                        <Pine.GSO.4.21.0011240006040.12702-100000@weyl.math.psu.edu> <14881.62969.786424.812353@notabene.cse.unsw.edu.au> <3A2437F6.6380A1BF@haque.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I just found a file with about the first 4k of it filled with nulls
(^@^@). No telling if this was a result of what originally started this
thread or not. I hadn't accessed that file since Nov 9th.


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
