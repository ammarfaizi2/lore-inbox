Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265843AbTGDITB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 04:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265851AbTGDITB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 04:19:01 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:7955 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S265843AbTGDIS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 04:18:59 -0400
Date: Fri, 04 Jul 2003 17:34:41 +0900 (JST)
Message-Id: <20030704.173441.71640872.yoshfuji@linux-ipv6.org>
To: j.dittmer@portrix.net
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: Unable to handle NULL point when doing lsof
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <3F0539E5.6030905@portrix.net>
References: <3F0539E5.6030905@portrix.net>
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

In article <3F0539E5.6030905@portrix.net> (at Fri, 04 Jul 2003 10:25:09 +0200), Jan Dittmer <j.dittmer@portrix.net> says:

> Just executing lsof gives a segmentation fault.
> This is 2.5.73-mm3 and reproducable on dual p3 and single p3-800.
> Will try 2.5.74-mm1 now.

Please try http://bugme.osdl.org/attachment.cgi?id=476&action=view
Thanks.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
