Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTKYJ2b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 04:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTKYJ2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 04:28:31 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:29200 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262139AbTKYJ23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 04:28:29 -0500
Date: Tue, 25 Nov 2003 18:28:44 +0900 (JST)
Message-Id: <20031125.182844.46174767.yoshfuji@linux-ipv6.org>
To: pnanaware@ggn.hcltech.com
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: Copy protection of the floppies
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <5F0021EEA434D511BE7300D0B7B6AB530CA67677@mail2.ggn.hcltech.com>
References: <5F0021EEA434D511BE7300D0B7B6AB530CA67677@mail2.ggn.hcltech.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <5F0021EEA434D511BE7300D0B7B6AB530CA67677@mail2.ggn.hcltech.com> (at Tue, 25 Nov 2003 11:07:29 +0530), "Pravin Nanaware , Gurgaon" <pnanaware@ggn.hcltech.com> says:

> 1> Could somebody suggest me the way to protect floppy from copying it's
> contents. 
> 2> If not possible, will it be possible to make the copied floppy unworkable
> (The copied floppy shouldn't work).  
>    For this I have constraint, I don't want to change the platform, which
> reads this floppy.

Basically, it depends on what kind of equipment you and the enemy have.
If you have special equipment and technique to write a floppy, you can make
a floppy which is not copiable by normal PCs.
But, if the enemy has similar equipment, he can do it.

About 15 years ago, there were many gaming softwares which were procected,
for example, by checking "gap" between sectors.  I also heard that there 
was a technique to change the hole of 5.25" (or 8") floppy for copy 
protection.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
