Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129725AbQLDWGW>; Mon, 4 Dec 2000 17:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129724AbQLDWGN>; Mon, 4 Dec 2000 17:06:13 -0500
Received: from nread2.inwind.it ([212.141.53.75]:36510 "EHLO relay4.inwind.it")
	by vger.kernel.org with ESMTP id <S129410AbQLDWGF>;
	Mon, 4 Dec 2000 17:06:05 -0500
From: Roberto Ragusa <robertoragusa@technologist.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 04 Dec 2000 22:21:53 +0200
Message-ID: <yam8373.2691.155547848@a4000>
In-Reply-To: <14888.93.991512.725794@notabene.cse.unsw.edu.au>
X-Mailer: YAM 2.1 [060] AmigaOS E-Mail Client (c) 1995-2000 by Marcel Beck  http://www.yam.ch
Subject: Re: kernel panic in SoftwareRAID autodetection
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-Dec-00, Neil Brown wrote:
> On Friday December 1, robertoragusa@technologist.com wrote:
>> I found a real showstopper problem in the SoftwareRAID autodetect
>> code; 2.4.0-test10 and 2.4.0-test11 are affected (I didn't test
>> previous versions).
[detailed report]
> 
> Fixed in 2.4.0-test12pre3.  

I tried 2.4.0-test12pre3.
The problem is *not* fixed: kernel panic again.

Please CC to me because I'm not a LKML subscriber.

-- 
        Roberto Ragusa   robertoragusa at technologist.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
