Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbULTHta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbULTHta (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 02:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbULTHqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 02:46:45 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:61956 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261472AbULTGio
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 01:38:44 -0500
Date: Mon, 20 Dec 2004 15:38:45 +0900 (JST)
Message-Id: <20041220.153845.70996857.yoshfuji@linux-ipv6.org>
To: davem@davemloft.net, roland@topspin.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org, akpm@osdl.org,
       torvalds@osdl.org, netdev@oss.sgi.com, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH][v4][0/24] Second InfiniBand merge candidate patch set
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200412192214.KlDxQ7icOmxHYIf0@topspin.com>
References: <200412192214.KlDxQ7icOmxHYIf0@topspin.com>
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

In article <200412192214.KlDxQ7icOmxHYIf0@topspin.com> (at Sun, 19 Dec 2004 22:14:43 -0800), Roland Dreier <roland@topspin.com> says:

> The following series of patches is the latest version of the OpenIB
> InfiniBand drivers.  We believe that this version is suitable for
> merging when 2.6.11 opens (or into -mm immediately), although of
> course we are willing to go through as many more iterations as
> required to fix any remaining issues.

Maybe, via the net queue. David?

--yoshfuji
