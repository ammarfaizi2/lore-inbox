Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbULNClY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbULNClY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 21:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbULNClY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 21:41:24 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:25104 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261382AbULNClT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 21:41:19 -0500
Date: Tue, 14 Dec 2004 11:42:59 +0900 (JST)
Message-Id: <20041214.114259.16194522.yoshfuji@linux-ipv6.org>
To: roland@topspin.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH][v3][20/21] Add InfiniBand Documentation files
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200412131010.qyAMW5NxoiM4CntC@topspin.com>
References: <20041213109.42OdQqmmAkW2Pv7s@topspin.com>
	<200412131010.qyAMW5NxoiM4CntC@topspin.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200412131010.qyAMW5NxoiM4CntC@topspin.com> (at Mon, 13 Dec 2004 10:10:04 -0800), Roland Dreier <roland@topspin.com> says:

> Add files to Documentation/infiniband that describe the tree under
> /sys/class/infiniband, the IPoIB driver and the userspace MAD access driver.
> 
> Signed-off-by: Roland Dreier <roland@topspin.com>

LICENSE.TXT is missing. Please add one.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
