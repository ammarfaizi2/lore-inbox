Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVDWRrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVDWRrQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 13:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVDWRrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 13:47:16 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:42244 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261633AbVDWRrO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 13:47:14 -0400
Date: Sun, 24 Apr 2005 02:49:38 +0900 (JST)
Message-Id: <20050424.024938.16544887.yoshfuji@linux-ipv6.org>
To: ismail.donmez@gmail.com
Cc: mikpe@csd.uu.se, linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: gcc-4.0.0 final miscompiles
 net/ipv4/devinet.c:devinet_sysctl_register()
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <2a4f155d05042310375d99994b@mail.gmail.com>
References: <200504230952.j3N9qm6W012596@harpo.it.uu.se>
	<2a4f155d05042310375d99994b@mail.gmail.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <2a4f155d05042310375d99994b@mail.gmail.com> (at Sat, 23 Apr 2005 20:37:23 +0300), ismail dönmez <ismail.donmez@gmail.com> says:

> Whats the bugzilla # for this so others can track it?

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=21173

--yoshfuji
