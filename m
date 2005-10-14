Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVJNKx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVJNKx2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 06:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVJNKx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 06:53:28 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:3595 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1750708AbVJNKx1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 06:53:27 -0400
Date: Fri, 14 Oct 2005 19:53:15 +0900 (JST)
Message-Id: <20051014.195315.106624870.yoshfuji@wide.ad.jp>
To: yzcorp@gmail.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yoshfuji@wide.ad.jp
Subject: Re: [PATCH]The type of inet6_ifinfo_notify event in
 addrconf_ifdown().
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
In-Reply-To: <434F8B23.7090201@gmail.com>
References: <434F8B23.7090201@gmail.com>
Organization: USAGI/WIDE Project
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

In article <434F8B23.7090201@gmail.com> (at Fri, 14 Oct 2005 18:40:35 +0800), Yan Zheng <yzcorp@gmail.com> says:

> Maybe inet6_ifinfo_notify event type should be RTM_DELLINK in 
> addrconf_ifdown().
> 
> Signed-off-by: Yan Zheng<yanzheng@21cn.com>
Acked-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

--yoshfuji
